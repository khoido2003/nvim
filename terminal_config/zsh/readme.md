# 💻 My ZSH Setup

This repo sets up my Zsh environment with:
- Oh My Zsh
- Powerlevel10k (p10k)
- Useful plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`
- `fzf` fuzzy finder

---

## 🚀 Quick Start (on a new machine)

0. Install Zsh and make it your default shell (Fedora)

```bash
sudo dnf install -y zsh
chsh -s $(which zsh)
```

1. **Clone this repo**
```bash
git clone https://github.com/khoido2003/nvim.git ~/.config/nvim

cd ~/.config/nvim/terminal_config/zsh/
```

2. **Make the install script executable
```
chmod +x install.sh
```

3. **Run the installer
```
chmod +x install.sh
```

## Configure P10K Wizard

If you want to re-run the Powerlevel10k config wizard later:
```
p10k configure
```
