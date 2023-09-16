---
title: Five useful git commands & options that are not being used often
layout: post
date: 2023-09-16 12:00:00
categories: git
---

`git` changed the way we all think of a source control program. It's simple yet powerful with a lot of features and capabilities; however, I see software engineers use only a handful of its commands in their day-to-day work. So, in this post, I would like to mention some git commands and options that are not being used so often but are very useful.

According to my observation (Probably people have already researched about it), These are the most used git commands by engineers: `clone`, `commit`, `push`, `pull`, `add`, `status`, `stash`, `log`, `merge`, and maybe `rebase` (I said maybe because the majority of people tend to use `merge` instead). Nowadays, I see some people also use the built-in git features in their preferred code editor or IDE. For example, in an IDE like PyCharm or VSCode, there's a very powerful git integration that a lot of people are using (and it's totally fine). However, somehow I don't feel comfortable using them. The fact is, I want to see exactly what is happening under the hood and be able to run those commands myself.

The following is a list of some commands and options that you may don't use often but they are very useful and powerful:

### `git commit --amend`

When I'm coding, I commit very often and I believe this is the right thing to do; however, some engineers commit only when they are finished with the task. Sometimes after saving a commit, I notice there are still things that I would like to include in the commit message. Or, sometimes after I commit and before I push the code, I suddenly realise that there are still things that I would like to include in the same commit. Of course, I can still add them to a different commit, but to make the commit history cleaner I prefer to include them in the current one (Yes, I might have an OCD). To do that, the `git commit --amend` can be used. If you add the `--amend` at the end of the commit, it will add the staged files to the last commit and it also allows you to modify the commit message if you want.

**Important:** _It's very important not to use `--amend` when you have already pushed the changes into the remote. Otherwise, the will be conflicts between your local and the remote._

### `git show`

I personally like this one a lot. A lot of times, you would like to understand what has changed in a commit. One way that is being used by most of the engineers I know is to use the Github/Gitlab GUI. However, you can do it easily offline as well using `git show`. To use this command, you need to have the commit hash (you can get it using `git log`):

```sh
git show 65de9d3c6afe0c75d5956b9fac692915881bd195
```

The above command shows all of the changes that happened in the commit `65de9d3c6afe0c75d5956b9fac692915881bd195`. A lot of time, you would like to know what's changed in the last commit. To do that you can use the `HEAD` keyword which points to the last commit in the tree.

```sh
git show HEAD
```

### `git diff [--staged]`

A lot of times before you commit your changes, you may like to know what you have changed. Using the `diff` command will help you. It's very similar to the `show` command we discussed above but for the current state of your work. One thing to note is that by default the `diff` command will now show changes that are staged. If you want to see those, you can use the `--staged` option.

### `git clone --depth=0`

There are a lot of cases where I want to clone a project and check the source code but I don't care about the history of all of the commits. This is mainly because I don't want to contribute to the project but like to only check the code. For 90% of the project, there's no such big difference given the recent internet connection speeds and computer hard drive capacities. However, there are still some projects that are too big to clone entirely. The Linux Kernel is a very good example of it. Android is another. When cloning a project you can use the `--depth` option to indicate the depth of history you would like to receive! If you would like to only have the latest state of the code, you can pass zero `0` to the`depth`.

### `git log [options]`

Git log is a classic git command. I also mentioned it in the beginning of the post. However, there are lots of very useful options that can be used to help you find what you want. Here are some of the them that I use the most:

`git log --author=[the email address or name of the person]` will show all of the commits by a specific person.

`git log --oneline` simplifies the log output by providing only the commit titles and not the details along with 7-character commit hashes.

`git log --since=[date] --after=[date]` will let you find the logs for the specific date range.

Nowadays, a lot of these commands and options I mentioned above are also available in your preferred Git service like GitHub and GitLab; but, as a person who prefers to spend more of his development time in the terminal, They are very useful. I hope you find it useful as well. If you know any cool git command that I haven't mentioned it here, please feel free to email me using the one provided in the contact page.
