---
title: How to fix VSCode's Go extension high CPU usage
date: 2020-08-07 05:00
categories: programming golang
layout: post
---

Writing Go code could be much easier if you use an IDE or text-editor plugin. Fortunately, there are some very good plugins for my text-editors of choice:

- [vim-go](https://github.com/fatih/vim-go){:target="blank"} plugin for VIM which provides Golang language support
- and [Go extension for VSCode](https://marketplace.visualstudio.com/items?itemName=golang.Go){:target="blank"} which provides the same functionality in Visual Studio Code.

The VSCode Go plugin however has an issue (or maybe misconfiguration): When using Go modules, the extension causes high CPU load!

## The problem

To be able to solve a problem we must first identify exactly what the problem is. When writing code in any language, VSCode is constantly running process(es) in background to be able to suggest autocompletion, intellisense, auto imports, and etc.

By default, the VSCode's Go plugin uses `gocode` tool to be able to provide autocompletion which is, as far as I understood, very slow and CPU intensive. This is an screenshot of macOS activity monitor when writing Go code in VSCode:

![GoCode high CPU load](/assets/images/gocode-high-cpu-load.png)

## The solution

To be able to provide autocompletion, the Go team provided [`gopls`](https://github.com/golang/tools/tree/master/gopls){:target="blank"}.

>`gopls` (pronounced: "go please") is the official language server for the Go language.

I'm not sure why the extension is not using the Go's default `gopls` tool for autocompletion. Maybe because the Go extension for VSCode was originally developed by Microsoft; but, recently it is maintained by the Go team at Google. As written in Go extension page:

>This is the new home for the VS Code Go extension. We just migrated from Microsoft/vscode-go. Learn more about our move on the Go blog.

Maybe they change it in future.

The good news is that you can change the configuration! All we need to do is to tell VSCode to use the `gopls` language server instead of `gocode` tool. To make coding in Go more enjoyable, I suggest to turn `formatOnSave` and `organizeImports` on as well. 

```js
"go.useLanguageServer": true,
"go.buildOnSave": "off",
"[go]": {
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports": true,
    },
    "editor.snippetSuggestions": "none",
},
"[go.mod]": {
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.organizeImports": true,
    },
},
"gopls": {
    "usePlaceholders": true
}
```

Note: In some cases, `gopls` tool may not be installed. If so, you can install it manually:

`
go get -u golang.org/x/tools/gopls
`

I saw a significant performance increase After switching to `gopls` and it became more enjoyable to write Go code. I hope you experience the same.
