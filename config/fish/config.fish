fnm env --use-on-cd --shell fish | source

export EDITOR=nvim

set -U fish_greeting

if status is-login
	if uwsm check may-start
		exec uwsm start hyprland.desktop
	end
end

set -g fish_key_bindings fish_vi_key_bindings

if status is-interactive
# Commands to run in interactive sessions can go here
end

