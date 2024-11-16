# Neovim Config

## Overview

This configuration will make Neonvim become a full-fledged IDE like VS Code

Theme: Gruvbox Dark Hard
Support: C#, JS/TS, Go, Java, HTML/CSS, Python

## Tools

This Neovim configuration will use LazyVim to manage all Neovim plugins and Mason to control the LSP server

## Prerequesites

Below is some dependencies needed to make sure all the code reccommendation and linting work for some specific language

### GUI: Neovide

Written in Rust so it is super fast and have some built in features with icon support
Dowload: https://neovide.dev/

### Win32Yank: Only on Window

This is important to enable copy and paste inside Neovim since it does not support it
Dowload: https://github.com/equalsraf/win32yank/releases

### LSP for C# and .NET:

Dowload Omnisharp and Visual Studio Build Tools

Omnisharp: https://github.com/OmniSharp/omnisharp-roslyn/releases/

Visual Studio Build Tools: https://visualstudio.microsoft.com/downloads/

### LSP for HTML, CSS

Using adminstrator access in CMD or Powershell to dowload by Nodejs:

- Language server
  bash

```
npm install -g vscode-langservers-extracted
```

- Prettier
  bash

```
npm install -g prettier
```

### LSP for Javascript/Typescript

bash

```
npm install -g typescript typescript-language-server


npm install -g eslint

```

### LSP for Java

Require using JDTLS but currently I can not set it up for some reason, will try to fix it in the future

## Requirements

Neovim >= 0.9.0 (needs to be built with LuaJIT)

Git >= 2.19.0 (for partial clones support)

a Nerd Font(v3.0 or greater) (optional, but needed to display some icons)
lazygit (optional)

## Results

![img](images/1.png)
_Folder Tree_

![img](images/2.png)
_Folder tree and editor_

![img](images/3.png)
_Find file_

![img](images/4.png)
_Auto completion_

![img](images/5.png)
_LazyVim Packet management _

![img](images/6.png)
_Find word in all files_

![img](images/7.png)
_Terminal_
