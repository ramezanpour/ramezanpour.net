---
title: How to convert markdown files to PDF?
date: 2020-03-03 10:50
layout: post
categories: review
---

Markdown is the markup language I got really interested in recently and I use it everywhere from generating the content of this blog to simple documents such as letters and GitHub `README` files and wikis.

As I have mentioned before in my previous posts, one my text editor of choice is currently Visual Studio Code. Using VSCode to edit markdown files are really enjoyable. The community developed a considerable amount of extensions you can choose to manipulate markdown files and in this post I want to talk about just two of them.

### MarkdownLint

[MarkdownLint](https://github.com/DavidAnson/vscode-markdownlint){:target="blank"} is one of the most popular extensions (with over 1.5M downloads as of today) which enables markdown syntax highlighting and formatting. The extension also provides live preview as well which let you see what will be the output as you type:

![MarkdownLint live preview](/assets/images/markdownlint_live_preview.png)

In addition, by enabling `formatOnSave` option in VSCode settings, it automatically reformat your markdown whenever you save a file.

### Markdown PDF

[Markdown PDF](https://github.com/yzane/vscode-markdown-pdf){:target="blank"} is probably one of the coolest markdown extensions of VSCode. The extension let you convert markdown files to HTML, PNG, JPEG and even PDF. To use it, simply press `Cmd+Shift+P`, search for _Markdown PDF_, and select your desired output format.

![Markdown PDF options](/assets/images/markdown_pdf_options.png)

Hope you like it.
