if status is-interactive
# Commands to run in interactive sessions can go here
	set fish_greeting
end

starship init fish | source

fish_add_path /home/colts/.spicetify

# Pi
fish_add_path "$HOME/.local/bin"
