---
title: How to access OS clipboard in neovim
layout: post
date: 2022-07-24 23:00 CET
categories: linux neovim
---

One of the cool things about (neo)vim is that it has its own clipboard system meaning if you copy (yank) something, you won't be able to just paste it in other apps because the clipboard is only available inside the editor. You might say this is not a good thing at all and I agree to some extend; however, in some cases it provides more flexibility.

Since I don't like this behavior as well, whenever I configure a new machine, one of the first things I usually do is to setup my neovim in a way that it can read and write to the system clipboard. Recently, I was setting up an Ubuntu 22.04 laptop as my primary work machine and had some problem dealing with the clipboard in neovim; so, I decided to post this and provide some guide on how to access the system clipboard in different operating systems.

## How it works actually?

Unlike vim, clipboard management in neovim is done via third-party apps. Consequently, you will need different tools for each OS you are working with. According to the neovim's official documentation, for each OS, specific tools are required. So let's dig in to each OS's configuration separately:

## macOS

The macOS configuration is probably the most straight-forward one since the `pbcopy` and `pbpaste` commands are already available. You all you need to do is to just set the clipboard correctly:

```vim
set clipboard+=unnamedplus
```

## Windows

To be able to system clipboard on Windows, you need to install `win32yank` app. You can download it from [here](https://github.com/equalsraf/win32yank). After that, you need to set the clipboard just the macOS:

```vim
set clipboard+=unnamedplus
```

**Note:** I haven't tried this myself since I don't have any Windows machine.

## Linux

Although accessing system clipboard should be the most straight-forward way on Linux; it's not :-/ It's actually depends on the window system that is being used. The two mostly used window systems are **Wayland** and **X11**:

### Wayland

If you are using Wayland as your windows system (The default in Ubuntu 22.04 and some other mainstream distributions), you need to have `wl-copy` and `wl-paste` commands accessible in your `$SHELL`. You can install these two tools by install `wl-clipboard` package.

`wl-clipboard` can be installed using your distro's package manager. For example in ubuntu you can use apt to install it:

```sh
sudo apt install wl-clipboard
```

However, if you couldn't find it, you can simply check the GitHub repo [here](https://github.com/bugaevc/wl-clipboard) and install from source code.

### X11

For X window system, you need to install `xclip`. Just like the instructions provided for the Wayland above, you should be able to install the package using the OS's package manager. Also, if you couldn't find it, you can also install it from source by checking the GitHub repo [here](https://github.com/astrand/xclip).

Finally after installing the required tools, you need to also set the `clipboard` just like macOS and Windows:

```vim
set clipboard+=unnamedplus
```
