---
title: File upload using Gin
categories: programming golang gin
date: 2020-09-12 00:15
layout: page
---

This post is my third post covering concepts of [Gin](https://gin-gonic.com/){:target="blank"}  , the HTTP web framework for Go. My previous post are:

- [How to use custom HTTP methods in Go Gin framework]({% post_url 2020-08-16-how-to-use-custom-http-method-in-go-gin-framework %})
- [How to enable CORS support in Gin]({% post_url 2020-08-23-cors-support-go-gin %})

In the RESTful era, most of our requests and responses' payloads are JSON. However, in some cases, you may want to upload a file instead. In this post I'm going to describe how to receive and save an uploaded file using Gin framework.

The most common way to upload a file in a web browser is via the html file upload element (`<input type="file" />`). To be able to let the server know that you're uploading a file, the request's `Content-Type` header must be set to `multipart/form-data`. Here's an example function for sending a file to a server using ReactJS and [Axios](https://github.com/axios/axios){:target="blank"}:

```jsx
import Axios from 'axios';

uploadFile = (file) => {
    const formData = new FormData();
    formData.append('file', file);
    Axios.post("https://example.com/upload", formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      })
      .then((resp) => {
        if (resp.status === 200) {
          console.log('File uploaded')
        }
      })
}
```

If everything goes fine, the file will be sent to the server. Now it's time to get the file and save it some where in our server. Fortunately, Gin provides a very simply way to receive files. Gin's `Context` argument (which all route handlers must have) has a `FromFile` method which helps you receive files from a multi-part content. Please take a look the following example:

```go
import (
    "net/http"
    "path/filepath"

    "github.com/gin-gonic/gin"
    "github.com/google/uuid" // To generate random file names
)

func saveFileHandler(c *gin.Context) {
    file, err := c.FromFile("file")

    // The file cannot be received.
    if err != nil {
        c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
            "message": "No file is received",
        })
        return
    }

    // Retrieve file information
    extension := filepath.Ext(file.Filename)
    // Generate random file name for the new uploaded file so it doesn't override the old file with same name
    newFileName := uuid.New().String() + extension

    // The file is received, so let's save it
    if err := c.SaveUploadedFile(file, "/some/path/on/server/" + newFileName); err != nil {
        c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
            "message": "Unable to save the file",
        })
        return
    }

    // File saved successfully. Return proper result
    c.JSON(http.StatusOK, gin.H{
        "message": "Your file has been successfully uploaded."
    })
}
```

As you can see in the above code, `saveFileHandler` is responsible for receiving and saving the file to the server. In line 10, we try to receive the uploaded file with the name `file`; then we check if the file is received successfully. To avoid conflicts, in line 23, we change the file name to a random string (UUID in this case). Finally, we attempt to save the file using Gin's `SaveUploadedFile` method and check if the save is saved. To handle errors, we return proper responses if any errors occurred. If every goes well and we could save the file to our path, we return the `200 OK` response to the client.

The above is a general example. You may want to validate the file you receive. In some cases, you just need to receive image files; so, file types should be validated. In addition, you may want to resize the received image before saving it.
