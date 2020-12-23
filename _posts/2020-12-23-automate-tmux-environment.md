---
title: Automate tmux environment creation
layout: post
date: 2020-12-23 15:00
categories: linux programming
---

As a software developer I always tend to tune my development environments. I usually do this by using and setting keyboard shortcuts and creating workflows that works best for me.

One of the environments that is essential to me is the terminal. I spend a lot of time everyday in it compiling and testing my code. In addition to that and because I love the simplicity of the terminal, I prefer to do other things than code-related stuff in it as well. For example, I use [Newsboat](https://github.com/newsboat/newsboat){:target="blank"} RSS reader to follow up my favorite blogs.

Every morning I start my day by setting up my `tmux` windows and panes. The first window is for my VPN connection (Since we can do nothing without a VPN connection in Iran) and `htop`. The second window is always for backend development. It usually contains a pane that belongs to `docker` and `docker-compose`, another for running my tests, and another for `neovim`. If I do freelancing, the third window goes to frontend development and so on. Because setting it up takes a little bit of time everyday, I decided to write a bash script to create all windows and panes for me automatically.

```bash
tmux new-session -d
tmux rename 'dev'
tmux renamew 'vpn'
tmux new-window -n 'backend' -c ~/go/src -d
tmux split-window -h -t 2. -c ~/go/src -d
tmux new-window -n 'frontend' -c ~/dev -d
tmux new-window -n 'other' -c ~/dev/scripts -d
tmux attach -t dev
```

Let's see what we have in here:

- In line 1 we create a new tmux session. The `-d` switch creates the session in detached mode.
- Line 2 renames the session name to `dev` in this case.
- Since the session always starts with a window by default, we rename the first window name by using `renamew` command in line 3.
- In line 4, we create the second window and name it `backend`. The `-c` option is used to specify the current working directory for that window. As you can see a `-d` option is also used to prevent switching to that window automatically.
- Line 5 splits the second window in half. The `-h` option is used for horizontal splitting. The `-t` switch is also used to specify which window should be split.
- Line 6 and 7 create two other windows named `frontend` and `other` with same arguments used in line 4.
- Finally we attach what we have created to the screen using the `attach` command. As you may have already guessed, the `-t` option is used to specify which session we should attach to the screen.

The script may seem very simple, but it saves me plenty of time every day. One routing I'm trying to adopt in my life is to automate whatever is possible to be automated. I hope you do the same because it saves you a lot of time and hence you can spend that freed time doing something more important.
