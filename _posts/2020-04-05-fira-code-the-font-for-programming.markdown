---
title: Fira Code - THE font for programming
layout: post
date: 2020-04-05 14:20
categories: programming
---

When I started programming on a GUI-based environment, the only fixed-width fonts available were `Courier` and `Courier New`. We actually didn't have lots of options to choose from. You may laugh at me but after 2 years of programming, I realized I can change the font size of Visual Studio IDE. In 2007, Microsoft introduced another moonscape font named `Consolas`. The font was much better and had better support anti-aliasing.

![DejaVu Sans Mono](/assets/images/dejavu_sans_mono_font_preview.png){:class="f-right"}

After moving to Linux in 2012, I got familiar with some other fonts. After trying out plenty of them, I found `DejaVu Sans` font family. `DejaVu Sans Mono` is one of the fonts I still love even after 6-7 years using it. I have temporarily switched to other fonts but got back to it after a short period of time.

Since we cannot leave the house as we usually did during the Coronavirus pandemic, I decided to play around with tools and apps I use the most and try out new things. As a result, I decided to search a little bit to see if I can find a replacement for the legendary `DejaVu` and actually found a fully-deserved one!

## Fira Code

`Fira Code` is my new favorite moonscape font! It's very clean and elegant and has also support for Retina displays which is the new standard for new laptops and monitors.

![Fira Code](/assets/images/fira_code_logo.svg)

Besides, what makes this fonts so lovely the way it solves a very important problem:

> Programmers use a lot of symbols, often encoded with several characters. For the human brain, sequences like ->, <= or := are single logical tokens, even if they take two or three characters on the screen. Your eye spends a non-zero amount of energy to scan, parse and join multiple characters into a single logical one. Ideally, all programming languages should be designed with full-fledged Unicode symbols for operators, but that’s not the case yet.

To be able to solve this issue, Fira Code contains a set of _ligatures_ for common multi-character combination we use everyday such as -> or !=; so it automatically convert those character combinations to its corresponding ligatures. Please take a look:

![Fira Code ligatures](/assets/images/fira_code_all_ligatures.png)

One other cool things about Fira is that it supports Powerline as well. If you are familiar with [Powerline](https://github.com/powerline/powerline), you may know that to be able to render Powerline fonts correctly, you need to Install a _[Powerline versions](https://github.com/powerline/fonts)_ of those fonts; but, Fira supports them out of the box.

Please take a look at Fira Code repository on [Github](https://github.com/tonsky/FiraCode) to find more information about the font and the installation instructions.
