function backup --description 'Auto-backup dotfiles to GitHub'
    echo "🔄 Refreshing chezmoi tracking..."
    chezmoi re-add
    
    echo "📦 Committing changes..."
    # Save current directory to jump back later
    set -l current_dir (pwd)
    cd (chezmoi source-path)
    
    git add .
    git commit -m "Auto-backup: (date '+%Y-%m-%d %H:%M:%S')"
    
    echo "🚀 Pushing to GitHub..."
    git push origin main
    
    cd $current_dir
    echo "✅ Backup complete!"
end

