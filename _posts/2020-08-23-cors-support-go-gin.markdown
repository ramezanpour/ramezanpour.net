---
title: How to enable CORS support in Gin
date: 2020-08-23 00:00
categories: programming golang
---
It's about 3 months that I'm trying to do some real work in Go and my HTTP framework of choice is [Gin](https://gin-gonic.com/){:target="blank"}.

After developing some REST APIs, I decided to create a frontend application to actually use them. When it comes to frontend development I usually choose ReactJS. Maybe I should write about why I like ReactJS over other frontend frameworks in the future ;)

When a client especially a web-based client wants to access an API, the server decides which clients are allowed to send requests. This is done by using called CORS which stands for Cross-origin resource sharing.

>Cross-origin resource sharing (CORS) is a mechanism that allows restricted resources on a web page to be requested from another domain outside the domain from which the first resource was served.

For more information about CORS please check [this Wikipedia article](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing){:target="blank"}

You can manually add the required headers to each response using Gin's `Header` method if you want:

```go
func CustomHeaderAPI(c *gin.Context) {
    // Add CORS headers
    c.Header("Access-Control-Allow-Origin", "http://example.com")
    c.Header("Access-Control-Allow-Methods", "PUT, POST, GET, DELETE, OPTIONS")

    // Prepare response
    c.JSON(http.StatusOK, gin.H{
        "message": "this response has custom headers"
    })
}
```

But it would be a pain in the neck to add the following lines of code to each API. To make things easier Gin supports middleware functions.

What are middleware functions? This is a good definition I found on the web:
>Middleware functions are functions that have access to the request object ( req ), the response object ( res ), and the next function in the application's request-response cycle.

You may create a middleware yourself to enable CORS support; but, we don't want to reinvent the wheel! A group of nice people in the community has developed a library to enable CORS support in Gin. It's called *CORS gin's middleware*.

To install it:

```bash
$ go get github.com/gin-contrib/cors
```

After installed, simply import it:

```go
import "github.com/gin-contrib/cors"
```

And start using it:

```go
package main

import (
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	// CORS for https://foo.com and https://github.com origins, allowing:
	// - PUT and PATCH methods
	// - Origin header
	// - Credentials share
	// - Preflight requests cached for 12 hours
	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"https://foo.com"},
		AllowMethods:     []string{"PUT", "PATCH"},
		AllowHeaders:     []string{"Origin"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		AllowOriginFunc: func(origin string) bool {
			return origin == "https://github.com"
		},
		MaxAge: 12 * time.Hour,
	}))
	router.Run()
}
```

The above configuration is the most complete example of what capabilities the library gives you. However, you may don't want to use them all. In fact, most of the projects' CORS configuration are identical. To make it even simpler, `cors` package also has something called `DefaultConfig` which returns a generic default configuration mapped to localhost. In my opinion, the best way to use this library is to add your custom configurations to the `DefaultConfig`'s result. For example, here is my own configuration for a project:

```go
router := gin.Default()
corsConfig := cors.DefaultConfig()

corsConfig.AllowOrigins = []string{"https://example.com"}
// To be able to send tokens to the server.
corsConfig.AllowCredentials = true

// OPTIONS method for ReactJS
corsConfig.AddAllowMethods("OPTIONS")

// Register the middleware
router.Use(cors.New(corsConfig))
```

Please support the library by star them on Github: <https://github.com/gin-contrib/cors>

I Hope it helps.
