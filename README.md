# Clone
To clone this repo, make sure you have following dependencies installed: `stow` and `gh`.

To install `gh` follow commands on this link: https://github.com/cli/cli/blob/trunk/docs/install_linux.md

In $HOME directory make sure to run following commands:


```
mkdir .dotfiles
cd .dotfiles/
gh repo clone dejanvujkov/dotfiles .
```

# Usage

To create link (and therefore make use of configuration) simply run command inside .dotfiles directory

```
stow .
```

That's it.

If you have already existing configuration, make sure to have it backed up before running stow eather renaming folders or running stow with `--adopt` flag to override it like so:

`stow --adopt .`
