---
title: How to use custom HTTP methods in Go Gin framework
date: 2020-08-16 12:00
layout: post
categories: golang programming gin
---

The [Gin framework](https://gin-gonic.com/){:target="blank"} is probably the most popular Go framework for creating RESTful APIs. It lets you create a web app in a matter of minutes.

When it comes to RESTful APIs, HTTP methods and status codes become very important. It's a best practice to divide your APIs' functionalities with different HTTP methods. For example, the method `POST` is used when want to **add** something to the database while the verb `PUT` is used for **updating** an entity.

By some conventions, some developers prefer to use custom verbs like `LIST`, `ASSIGN`, `LOGIN`, and etc. as well. For instance, if a list of all categories need to be retrieved, instead of using the `GET` method, `LIST` can be used. Gin supports the most common HTTP methods by default. These methods are `GET`, `POST`, `PUT`, `DELETE`, `HEAD`, `PATCH`, and `OPTIONS`.

Here is an example of a very simple web API using Gin:

```go
package main

import (
 "net/http"

 "github.com/gin-gonic/gin"
)

func main() {
 router := gin.Default()
 router.GET("/hello", sayHello)
 router.Run(":3000")
}

func sayHello(c *gin.Context) {
 c.JSON(http.StatusOK, gin.H{
  "message": "Hello!!",
 })
}
```

But what if you want to use some custom HTTP methods? In this case Gin provides a some lower level method called `Handle`. Please take a look at the following example:

```go
package main

import (
 "net/http"

 "github.com/gin-gonic/gin"
)

func main() {
 router := gin.Default()
 router.GET("/hello", sayHello)
 router.Handle("LIST", "/get", getList)
 router.Run(":3000")
}

func sayHello(c *gin.Context) {
 c.JSON(http.StatusOK, gin.H{
  "message": "Hello!!",
 })
}

func getList(c *gin.Context) {
 // Gets the list of all categories
}
```

As you can see in the above example, instead of using the built-in methods, you can use the `Handle` method to use custom HTTP verbs. the `Handle` method takes three arguments instead of two, and the first argument is the method name in `string`. Using this you can have whatever method you prefer.

Hope it helps.
