eval "$(starship init zsh)"

# Add .NET 8
# export DOTNET_8_ROOT="/opt/homebrew/opt/dotnet@8"
# export PATH="$DOTNET_8_ROOT/bin:$PATH"

# Add .NET 9 (or latest)
# export DOTNET_9_ROOT="/opt/homebrew/opt/dotnet"
# export PATH="$DOTNET_9_ROOT/bin:$PATH"
#
# alias use-dotnet8='export DOTNET_ROOT="/opt/homebrew/opt/dotnet@8" && export PATH="$DOTNET_ROOT/bin:$PATH"'
# alias use-dotnet9='export DOTNET_ROOT="/opt/homebrew/opt/dotnet" && export PATH="$DOTNET_ROOT/bin:$PATH"'
#

export PATH="$HOME/.dotnet-core-tools:$PATH"
export DOTNET_ROOT="$HOME/.dotnet-core-tools"
export PATH="$PATH:/Users/dejanvujkov/.dotnet/tools"

alias ll='ls -l'
alias la='ls -a'
alias jmeter='open /opt/homebrew/bin/jmeter'

alias v='nvim'
alias vl="NVIM_APPNAME=LazyVim nvim"

export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

function nvims() {
	items=("default", "lazy")
	config=$(printf "%s\n" "${items[@]}" | fzf --prompt="config> " --layout=reverse --height=50% --border --exit-0)
	if [[ -z "$config" ]]; then
		echo "No config selected"
		return 0
	elif [[ "$config" == "default" ]]; then
		config=""
	fi
	NVIM_APPNAME=$config nvim $@
}
