# GitHub SSH Setup Guide (Linux & Windows)

This guide configures Git to authenticate with GitHub using SSH keys instead of HTTPS passwords/tokens.

---

# Why SSH?

Benefits:

* No need to enter GitHub username/password on every push
* More secure than password authentication
* Works with GitHub, GitLab, and Bitbucket
* One-time setup per machine

---

# Step 1: Install Git

## Linux (Ubuntu / KDE Neon)

```bash
sudo apt update
sudo apt install git
```

Verify:

```bash
git --version
```

## Windows

Download and install Git:

https://git-scm.com/download/win

Verify:

```powershell
git --version
```

---

# Step 2: Configure Git Identity

Replace with your information.

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Verify:

```bash
git config --global --list
```

Expected:

```text
user.name=Your Name
user.email=your@email.com
```

---

# Step 3: Check Existing SSH Keys

## Linux

```bash
ls ~/.ssh
```

## Windows PowerShell

```powershell
Get-ChildItem $HOME\.ssh
```

If you already see:

```text
id_ed25519
id_ed25519.pub
```

you may reuse them.

Otherwise continue.

---

# Step 4: Generate a New SSH Key

## Linux

```bash
ssh-keygen -t ed25519 -C "your@email.com"
```

## Windows PowerShell

```powershell
ssh-keygen -t ed25519 -C "your@email.com"
```

When prompted:

```text
Enter file in which to save the key:
```

Press ENTER.

Default location:

```text
~/.ssh/id_ed25519
```

When prompted for passphrase:

```text
Enter passphrase:
```

Options:

* Enter a secure passphrase (recommended)
* Press ENTER for no passphrase

Files created:

```text
id_ed25519
id_ed25519.pub
```

---

# Step 5: Start SSH Agent

## Linux

Start agent:

```bash
eval "$(ssh-agent -s)"
```

Add key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Verify:

```bash
ssh-add -l
```

---

## Windows PowerShell (Administrator)

Enable SSH agent:

```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
```

Add key:

```powershell
ssh-add $HOME\.ssh\id_ed25519
```

Verify:

```powershell
ssh-add -l
```

---

# Step 6: Copy Public Key

## Linux

```bash
cat ~/.ssh/id_ed25519.pub
```

## Windows

```powershell
Get-Content $HOME\.ssh\id_ed25519.pub
```

Copy the entire line.

Example:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA... your@email.com
```

---

# Step 7: Add SSH Key to GitHub

Open:

https://github.com/settings/keys

Click:

```text
New SSH Key
```

Fill:

```text
Title: KDE Neon Laptop
```

or

```text
Title: Windows Desktop
```

Paste your public key.

Click:

```text
Add SSH Key
```

---

# Step 8: Test Connection

Run:

```bash
ssh -T git@github.com
```

First time:

```text
Are you sure you want to continue connecting?
```

Type:

```text
yes
```

Successful result:

```text
Hi username! You've successfully authenticated,
but GitHub does not provide shell access.
```

---

# Step 9: Use SSH Instead of HTTPS

Check remote:

```bash
git remote -v
```

HTTPS example:

```text
origin https://github.com/user/repo.git
```

Convert to SSH:

```bash
git remote set-url origin git@github.com:user/repo.git
```

Verify:

```bash
git remote -v
```

Expected:

```text
origin git@github.com:user/repo.git
```

---

# Step 10: Push Code

```bash
git push origin main
```

If configured correctly:

* No username prompt
* No password prompt
* Push succeeds immediately

---

# Troubleshooting

## Authentication Failed

Error:

```text
fatal: Authentication failed
```

Check remote:

```bash
git remote -v
```

If it starts with:

```text
https://
```

switch to SSH.

---

## Permission Denied (publickey)

Error:

```text
Permission denied (publickey)
```

Check:

```bash
ssh-add -l
```

If empty:

```bash
ssh-add ~/.ssh/id_ed25519
```

---

## Test GitHub Connection

```bash
ssh -T git@github.com
```

Must show:

```text
You've successfully authenticated
```

before Git pushes will work.

---

# Quick Setup Checklist

Install Git:

```bash
sudo apt install git
```

Configure Git:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@email.com"
```

Generate key:

```bash
ssh-keygen -t ed25519 -C "you@email.com"
```

Add key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Copy public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add key to GitHub:

```text
https://github.com/settings/keys
```

Test:

```bash
ssh -T git@github.com
```

Switch remote:

```bash
git remote set-url origin git@github.com:user/repo.git
```

Push:

```bash
git push origin main
```

