---
title: Apply coding standards by using pre-commit
layout: post
date: 2022-03-25 21:00 CET
---

When working on a project in a team, it's typical that engineers' coding styles might be different.
It's fine in the first place; however, if the number of engineers increases, you may end up having multiple coding styles in the project.

For example, one may prefer a line length of `80`, the other may like `120`. One may use Windows OS in which the line endings are `\r\n` while one may use a UNIX-like OS like macOS in which `\n` is used. Furthermore, it is very difficult to catch these types of during the code-review. No one likes (or can) take care of these tiny things because we are humans and making mistakes is part of our day-to-day life.

Also, there might be some runtime issues that cannot be identified during the development and testing. For instance, in Python projects, you may have a function like this:

```python
def sum(a, b):
    return a + b
```

But then by mistake, you may use the function like this:

```python
result = sum("1", "2")
```

Theoretically, the function definition and usage is correct. But is that really what you want? This may seem very obvious and trivial but believe me, in real-world projects, these things happen!

Although some of these human and runtime errors can be identified by the reviewer(s), there will be cases in which they may forget to spot them. As a result, the optimal way is to automate these processes. There are several tools out there for this type of automation but the one that I like and use is [pre-commit](https://pre-commit.com).

## How it works

As the name implies, pre-commit can be triggered when the user attempts to "commit" a new change. This is done by defining a new git hook. After the attachment, each time the `git commit` is run, pre-commit start checking all _changed_ files.

To install pre-commit you can use your OS package manager. I am using macOS and Homebrew so the command to install would be:

```bash
brew install pre-commit
```

After installation, you need to install the git hook scripts. This is done by running the following in the repo directory:

```sh
$ pre-commit install
pre-commit installed at .git/hooks/pre-commit
```

After this pre-commit starts automatically every time a new commit is going to be created.

You can also trigger pre-commit manually and on all files inside the project by running. This is very useful you can run the checks again in your CI/CD pipeline:

```sh
pre-commit run --all-files
```

After the installation process is finished it's now time to start configuring the pre-commit

## Configurations

Pre-commit works by running some hooks that is defined as configurations. You can configure pre-commit by adding the `.pre-commit-config.yaml` file to your project. Here's an example:

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v2.3.0
    hooks:
      - id: check-yaml
      - id: check-json
      - id: end-of-file-fixer
      - id: trailing-whitespace
  - repo: https://github.com/psf/black
    rev: 21.12b0
    hooks:
      - id: black
```

Each configuration starts with a list of `repos` in which the hooks exist. Each repo can have one or more hooks. In the above example, there are two repos defined. The first is the pre-commit's default hooks repository which contains lots of useful hooks such as `check-yaml`, `check-json`, `end-of-file-fixer`, and `trailing-whitespace` that we have used. The second is the `black` hook which is a Python code formater. When a new commit is added, these hooks will be run automatically.

**Note: When you change the pre-commit configuration file, it's recommended to run `pre-commit install` again to fetch newly added hooks**

For more information about pre-commit's default hooks please check <https://github.com/pre-commit/pre-commit-hooks>

Using pre-commit for us is critical because it saves us a lot of time and energy, especially during code reviews.
