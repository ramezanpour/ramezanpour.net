---
title: Moving to Jekyll
categories: musing
layout: post
date: 2020-02-05 15:18:00 +0330
---

When I [started this blog at 2008](https://web.archive.org/web/20080414002254/http://www.ramezanpour.net/){:target="\_blank"}, I used [BlogEngine](https://blogengine.io/){:target="\_blank"} blogging platform to publish my posts. I chose BlogEngine because it was (Or maybe is) written in .NET and I was a .NET enthusiast at that time. After a few years of blogging with The BlogEngine platform, I decided to move to WordPress. WordPress the the most popular blogging platform and I was very satisfied with it. It has a very powerful text editor and a feature-rich administrator panel.

The problem starts when I lost all of my posts! I was a GoDaddy user for a couple of years and due to International sanctions against Iran, I couldn't pay for my subscription and didn't have backup of my posts.

WordPress is actually an awesome platform; however, to to able to deploy it to your website, You should install a few prerequisites. The first requirement is the PHP programming languages because it is written in PHP. The second is the MySQL database!

This could cause some minor issues when wanting to backup your website data. To create a backup in WordPress, you will need to backup your not only your files but your database as well.

### Jekyll

[Jekyll](https://jekyllrb.com/){:target="\_blank"} is a very simple programmer-friendly blogging platform. I works by compiling markdown files into pure HTML files. All you need to do is to create a markdown file, write your post and then compile it to HTML files. You can then upload those files to your hosting storage or using simply use [GitHub Pages](https://pages.github.com){:target="\_blank"} and forget about paying for hosting storage since Github gives you unlimited bandwidth and storage.

When using Jekyll with GitHub Pages, you have to `git push` your files into a Github repository to post them to be able to see them on your website. By doing so, you have also backed up your code as well.

If you're interested as I do, you can give Jekyll a try . In addition, you can access the source code of this blog by [clicking here](https://github.com/ramezanpour/ramezanpour.net)
