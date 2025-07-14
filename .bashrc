# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH="/opt/homebrew/bin:$PATH"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

alias ll='ls -al'
alias dev='distrobox-enter dev'

eval "$(starship init bash)"

# export DOTNET_8_ROOT="/home/linuxbrew/.linuxbrew/opt/dotnet@8"
# export PATH="$DOTNET_8_ROOT/bin:$PATH"
# # Add .NET 9 (or latest)
# export DOTNET_9_ROOT="/home/linuxbrew/.linuxbrew/opt/dotnet@9"
# export PATH="$DOTNET_9_ROOT/bin:$PATH"
#
# alias use-dotnet8='export DOTNET_ROOT="/home/linuxbrew/.linuxbrew/opt/dotnet@8" && export PATH="$DOTNET_ROOT/bin:$PATH"'
# alias use-dotnet9='export DOTNET_ROOT="/home/linuxbrew/.linuxbrew/opt/dotnet" && export PATH="$DOTNET_ROOT/bin:$PATH"'

# export PATH="$HOME/.dotnet-core-tools:$PATH"
# export DOTNET_ROOT="$HOME/.dotnet-core-tools"

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"

function nvims() {
	items=("default", "LazyVim")
	config=$(printf "%s\n" "${items[@]}" | fzf --prompt="config> " --layout=reverse --height=50% --border --exit-0)
	if [[ -z "$config" ]]; then
		echo "No config selected"
		return 0
	elif [[ "$config" == "default" ]]; then
		config=""
	fi
	NVIM_APPNAME=$config nvim $@
}
