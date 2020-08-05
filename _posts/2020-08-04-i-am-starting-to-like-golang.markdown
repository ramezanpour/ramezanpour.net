---
title: I am starting to like Golang
date: 2020-08-04 19:00
categories: programming golang
layout: post
---

Lock down during COVID-19 pandemic continues and we have no choice but to stay home. Although we have missed lots things, it gives us the opportunity to learn and read more.

During the last four years, nearly all projects I worked on was written in Python. I like Python and it's getting better every day. However, in the last 3 months or so, I had enough time to get familiar with [Golang](https://golang.org){:target="blank"}!

## Learning curve

As a developer with near 15 years of working experiences, learning a new programming language shouldn't be too hard; but, Golang was different. In the decade, every app I have developed, from C++ to Python and everything in between, was written with an object-oriented programming language. The most difficult challenge I faced when started developing my first _practical application_ in Go was the lack of OOP principals. However, the more I used Go, the more I realized things **can** be done differently!

Here are some examples:

## Exported Names

For example, although Golang does not have the encapsulation features such as `private`, `public`, `protected` or `friend`, it has something called **exported name**! When a function or field starts capital letter, it will be considered as an exported name which means it can be accessed from other packages.

```go
package tools

// Private function. It can be accessed only inside tools package.
func sum(a, b int) int {
    return a + b
}

// Exported function. Anyone can access this function from other packages.
func Multiply(a, b int) int {
    return a * b
}
```

## Struct methods

As an another example, because Go is not an OOP language, it doesn't have classes; however, just like C, it has `structs`. Structs are types that are collection of fields. But unlike C, structs can have related methods! Please take a look the following example:

```go
package example

type Person struct {
    ID uint
    FirstName string
    LastName string
    Age uint
}

// C like functions to return the full name
func GetPersonFullName(p *Person) string {
    return p.FirstName + " " + p.LastName
}

// Go struct methods
func (p *Person) GetFullName() string {
    return p.FirstName + " " + p.LastName
}
```

It's still possible to write C-like code and it's totally fine; but it could be much cleaner it you use the second method. Now let's use the two functions we have written above:

```go
package example

p := &Person{
    ID: 1,
    FirstName: "Mohammad Mahdi",
    LastName: "Ramezanpour",
    Age: 33,
}

// Call the first function
fullName := GetPersonFullName(p)

// Call the struct method
fullName := p.GetFullName()
```

## Pointers

Go is a modern programming language and it has almost everything any modern programming language has. But unlike most of them, it has pointers! As you may know, pointers are game changers when it comes to high-performance software development. But they can be problematic as well!

In low-level languages such as C or C++, the developer is responsible for managing the memory and as all humans make mistakes, one can take a part of memory from the OS and forget to free it which could lead to memory leaks and app crashes. This is why some high-level programming languages such as Java and C# has something called garbage collector (GC). GC is responsible for taking care of memory allocations that are not in use anymore.

The great news is that Go has both pointers and GC!!! This simply let you have control over the memory but if you make a mistake, Go will take care of it.

## Last words

As I'm getting deeper into Golang world, I'm getting more and more excited about the language. If you haven't tried Go, you should definitely check it out. It's the language to learn.
