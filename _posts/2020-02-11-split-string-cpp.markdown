---
title: Different ways to split a string in C++
layout: post
date: 2020-02-11 23:33
categories: programming c++
---

All high-level programming languages provide a large amount of functions for strings manipulation and splitting is one of the most useful ones. Here are some example of how to perform a string split in Python and C# programming languages:

**Python:**

```python
s = 'Hello world'
result = s.split(' ')

# Result is ['Hello', 'world']
```

**C#:**

```cs
var str = "Hello world";
result = str.Split([' ']);

// Result is ['Hello', 'world']
```

In C++ there is not such built-in functions to split a string by a delimiter; however, it is possible to write your own split function. There are two approaches though:

### In classic C way

In C standard library has a `<string.h>` header file that provides some useful functions for string manipulation and one of them is `strtok`.

> The `strtok()` function is used to isolate sequential tokens in a null-terminated string, str. These tokens are separated in the string by at least one of the characters in sep.

```c
#include "string.h"
#include "stdio.h"

char* str = "Hello world";
char* splitted = strtok(str, " ");
while (splitted != NULL) {
    printf("%s", splitted);
    splitted = strtok(NULL, " ");
}
```

In the about example, please consider the following description:

> The first time that `strtok()` is called, str should be specified; subsequent calls, wishing to obtain further tokens from the same string, should pass a `null`
> pointer instead. The separator string, sep, must be supplied each time, and may change between calls.

Please also note that if you want to use the above code in a C++ application, you should change the include section `string.h` to `<cstring>`.

### The modern C++ way

The other approach is to use C++11 `std::string` class. The new string class provides various useful functions to work with strings. However and as far as I know, it doesn't have any split functions yet. But you can simply create one using other functions provided in the `string` class. The following is an implementation of `split` function in C++:

```c++
#include <string>
#include <vector>

std::vector<std::string> split(const std::string &str, const std::string &delim)
{
    std::vector<std::string> tokens;
    size_t prev = 0, pos = 0;
    do
    {
        pos = str.find(delim, prev);
        if (pos == std::string::npos)
            pos = str.length();
        std::string token = str.substr(prev, pos - prev);
        if (!token.empty())
            tokens.push_back(token);
        prev = pos + delim.length();
    } while (pos < str.length() && prev < str.length());
    return tokens;
}
```

As you can see in the above code, we have used the built-in `find` and `substr` functions to implement our own split! Finally we pushed each token to a `vector` and return it to the user. The reason we have used the `vector` is because we don't know how many items would be in our result list.
