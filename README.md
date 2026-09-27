# Very simple dotfiles
use chezmoi to merge these
## Process to merge with chezmoi

1. log in with git (Use github-cli or other method)
  -gh auth login

2. chezmoi init apply "this repo" 

### Adding more files

```bash
chezmoi add ~/.config/filename
```

### Push changes to GitHub
```bash
chezmoi re-add
chezmoi git -- push
```

### Check what has changed locally
If you want to see what tweaks you made before backing them up:
```bash
chezmoi diff
```

