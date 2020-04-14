---
title: How to correct typos in VS code
layout: post
date: 2020-04-14 12:30
categories: programming
---

This #StayAtHome trend has given me enough time (more than enough actually) to try out new things; from [changing my development fonts]({% post_url 2020-04-05-fira-code-the-font-for-programming %}) after 6 years, or to try out [new themes]({% post_url 2020-02-26-everybody-is-talking-dark-right-now %}).

I have recently moved from "all other editors and IDEs" to Visual Studio Code and trying to make it my new home. One of the things I believe every text editor should have is spell checking. Unfortunately, VSCode does not have spell checking out of the box but there is an extension for it thanks to the community.

## Code Spell Checker

The extension is [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker){:target="blank"}. What it does is providing a _basic spell checking that also supports camelCase_. Although it's very simple and works right out of the box, it's highly configurable as well. For example, you may want to disable spell checking for a specific programming language. In this case you can add the following configuration to your `settings.json`:

```go
"cSpell.enableFiletypes": [
    "!go" // ! excludes go extension
]
```

In addition, following are other configurations you may want to manipulate:

```go
// The Language local to use when spell checking. "en", "en-US" and "en-GB" are currently supported by default.
"cSpell.language": "en",

// Controls the maximum number of spelling errors per document.
"cSpell.maxNumberOfProblems": 100,

// Controls the number of suggestions shown.
"cSpell.numSuggestions": 8,

// The minimum length of a word before checking it against a dictionary.
"cSpell.minWordLength": 4,

// Specify file types to spell check.
"cSpell.enabledLanguageIds": [
    "csharp",
    "go",
    "javascript",
    "javascriptreact",
    "markdown",
    "php",
    "plaintext",
    "typescript",
    "typescriptreact",
    "yml"
],

// Enable / Disable the spell checker.
"cSpell.enabled": true,

// Display the spell checker status on the status bar.
"cSpell.showStatus": true,

// Words to add to dictionary for a workspace.
"cSpell.words": [],

// Enable / Disable compound words like 'errormessage'
"cSpell.allowCompoundWords": false,

// Words to be ignored and not suggested.
"cSpell.ignoreWords": ["behaviour"],

// User words to add to dictionary.  Should only be in the user settings.
"cSpell.userWords": [],

// Specify paths/files to ignore.
"cSpell.ignorePaths": [
    "node_modules",        // this will ignore anything the node_modules directory
    "**/node_modules",     // the same for this one
    "**/node_modules/**",  // the same for this one
    "node_modules/**",     // Doesn't currently work due to how the current working directory is determined.
    "vscode-extension",    //
    ".git",                // Ignore the .git directory
    "*.dll",               // Ignore all .dll files.
    "**/*.dll"             // Ignore all .dll files
],

// flagWords - list of words to be always considered incorrect
// This is useful for offensive words and common spelling errors.
// For example "hte" should be "the"`
"cSpell.flagWords": ["hte"],

// Set the delay before spell checking the document. Default is 50.
"cSpell.spellCheckDelayMs": 50,
```

You can also contribute to this project: [https://github.com/streetsidesoftware/vscode-spell-checker](https://github.com/streetsidesoftware/vscode-spell-checker)
