<a href="https://dotfyle.com/khoido2003/neovimconfig"><img src="https://dotfyle.com/khoido2003/neovimconfig/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/khoido2003/neovimconfig"><img src="https://dotfyle.com/khoido2003/neovimconfig/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/khoido2003/neovimconfig"><img src="https://dotfyle.com/khoido2003/neovimconfig/badges/plugin-manager?style=for-the-badge" /></a>

# Welcome to My Neovim Setup!

This is a **super fast** Neovim configuration that starts up in **50 ms or less**! It’s designed to be simple yet powerful, with a cool **Monokai** colorscheme to make coding look great.

---

## Install Instructions

 > Install requires Neovim 0.10+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:khoido2003/neovim_config ~/.config/khoido2003/neovim_config
```

Open Neovim with this config:

```sh
NVIM_APPNAME=khoido2003/neovim_config/ nvim
```

## What's this all about
- Speed: Starts up blazingly fast (≤50 ms).
- Look: Uses the Monokai theme for a sleek, modern vibe. (https://github.com/polirritmico/monokai-nightasty.nvim)
- Tools: Manages plugins with LazyVim and LSP servers with Mason.nvim.
- Keybindings: Easy-to-use shortcuts for editing, navigation, and more (check them out below!).


## Plugins

### colorscheme

+ [polirritmico/monokai-nightasty.nvim](https://dotfyle.com/plugins/polirritmico/monokai-nightasty.nvim)
### completion

+ [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)
### editing-support

+ [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
+ [windwp/nvim-ts-autotag](https://dotfyle.com/plugins/windwp/nvim-ts-autotag)
+ [HiPhish/rainbow-delimiters.nvim](https://dotfyle.com/plugins/HiPhish/rainbow-delimiters.nvim)
### file-explorer

+ [nvim-tree/nvim-tree.lua](https://dotfyle.com/plugins/nvim-tree/nvim-tree.lua)
### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
### fuzzy-finder

+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
### git

+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
+ [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
### icon

+ [kyazdani42/nvim-web-devicons](https://dotfyle.com/plugins/kyazdani42/nvim-web-devicons)
### lsp

+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
### lsp-installer

+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)
### nvim-dev

+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### snippet

+ [L3MON4D3/LuaSnip](https://dotfyle.com/plugins/L3MON4D3/LuaSnip)
### statusline

+ [echasnovski/mini.statusline](https://dotfyle.com/plugins/echasnovski/mini.statusline)
### syntax

+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
### terminal-integration

+ [akinsho/toggleterm.nvim](https://dotfyle.com/plugins/akinsho/toggleterm.nvim)

## Language Servers

+ clangd
+ cssls
+ gdscript
+ gopls
+ html
+ jdtls
+ lua_ls
+ omnisharp
+ pyright
+ rust_analyzer
+ svelte
+ tailwindcss
+ yamlls

## Keymappings

This configuration includes ergonomic keybindings for navigation, editing, and Git/LSP workflows. Below is a summary:

### Window Navigation
| Key         | Action             |
|-------------|--------------------|
| `Ctrl + h`  | Move to left pane  |
| `Ctrl + j`  | Move to down pane  |
| `Ctrl + k`  | Move to up pane    |
| `Ctrl + l`  | Move to right pane |

### Editing
| Key         | Action                |
|-------------|-----------------------|
| `Ctrl + s`  | Save file             |
| `Ctrl + z`  | Undo                  |
| `Ctrl + c`  | Copy to clipboard     |
| `Ctrl + v`  | Paste from clipboard  |
| `Ctrl + a`  | Select all text       |
| `Del`       | Delete (visual mode)  |
| `Alt + j`   | Move line down        |
| `Alt + k`   | Move line up          |
| `Ctrl + /`  | Toggle comment        |

### Search and Navigation
| Key         | Action                     |
|-------------|----------------------------|
| `Leader + f` | Start search              |
| `Leader + ff`| Find files (Telescope)    |
| `Alt + f`   | Live grep (Telescope)     |
| `Alt + Shift + f` | Fuzzy find in buffer |
| `Tab`       | Next buffer               |
| `Shift + Tab` | Previous buffer         |
| `Up`/`Down` | Navigate wrapped lines    |
| `Enter`     | Select current line       |

### File Explorer
| Key         | Action                |
|-------------|-----------------------|
| `Leader + e`| Toggle NvimTree       |

### LSP (Language Server Protocol)
| Key         | Action                  |
|-------------|-------------------------|
| `Leader + gd`| Go to definition       |
| `Leader + gr`| Go to references       |
| `Leader + gt`| Go to type definition  |
| `Leader + rn`| Rename symbol          |
| `Leader + k` | Hover documentation    |
| `Leader + sh`| Signature help         |
| `Leader + ca`| Code action            |
| `Leader + d` | Show diagnostics (float)|

### Git (via Gitsigns)
| Key         | Action                  |
|-------------|-------------------------|
| `Leader + nh`| Next hunk              |
| `Leader + ph`| Previous hunk          |
| `Leader + rh`| Reset hunk             |
| `Leader + rb`| Reset buffer           |
| `Leader + df`| Show diff              |
| `Leader + bl`| Blame line             |
| `Leader + gs`| Toggle Git signs       |

### Diffview
| Key         | Action                  |
|-------------|-------------------------|
| `Leader + do`| Open Diffview          |
| `Leader + dc`| Close Diffview         |
| `Leader + dr`| Refresh Diffview       |
| `Leader + dh`| File history (all)     |
| `Leader + dhf`| File history (current)|

### Terminal
| Key         | Action                  |
|-------------|-------------------------|
| `Ctrl + t`  | Toggle terminal         |



## Prequesites

- Autoformat code with Conform.nvim: https://github.com/stevearc/conform.nvim

    + To have Conform.nvim auto format for each programming language, on local machine
    need to dowload the relevant formatter

    + For example: JS/TS -> Prettier

- LSP server will be dowloaded automatically by Mason.nvim


## Nerd font
Recommend dowload FiraCode for better font and syntax support

Dowload: https://github.com/tonsky/FiraCode

### Dowload Zig as compiler for Nvim-Tree-sitter
Using chocolatey
bash

```
choco install zig
```
or visit Zig website for more guide: https://ziglang.org/learn/getting-started/#direct

### Install Lazygit to use Git in terminal

bash
```
choco install lazygit
```

![img](images/7.png)


### Win32Yank(Window)

This is important to enable copy and paste inside Neovim since it does not support it
Dowload: https://github.com/equalsraf/win32yank/releases


## Requirements

- Neovim >= 0.10.0 

- Git >= 2.19.0 

- Nerd Font(v3.0 or greater) (optional, but needed to display some icons)

- lazygit (optional)

## Results

![img](images/0.jpg)

![img](images/1.png)

![img](images/2.png)

![img](images/3.png)

![img](images/4.png)

![img](images/5.png)

![img](images/6.png)

![img](images/7.png)
