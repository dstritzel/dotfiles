# Dotfiles

This repository contains my personal dotfiles, managed with [rcm](https://github.com/thoughtbot/rcm).

Use apt or brew to install rcm.

## Usage

Once rcm is installed, you can use these commands to manage your dotfiles:

### Install dotfiles (symlink to home directory)

```bash
rcup -v
```

### List all managed dotfiles

```bash
lsrc
```

### Add a new dotfile to the repository

```bash
mkrc ~/.bashrc
```

### Remove symlinks

```bash
rcdn
```

## Directory Structure

- `hooks/` - Pre and post installation hooks
- `host-*` - Host-specific dotfiles
- `tag-*` - Tag-specific dotfiles (linux, mac, wsl)
