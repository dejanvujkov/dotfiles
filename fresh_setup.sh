# install homebrew if not installed
if ! command -v brew &> /dev/null
then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else echo "Homebrew is already installed"

fi

# list of packages to install
packages=(
	"git"
	"npm"
	"ripgrep"
	"fzf"
	"go"
	"gh"
	"nvim"
	"stow"
	"lazygit"
)

# install packages if not installed
for package in "${packages[@]}"
do
	if ! command -v $package &> /dev/null
	then
		brew install $package
	else echo "$package is already installed, skipping"
	fi
done

git config --global user.email "dejanvujkov@gmail.com"
git config --global user.name "Dejan Vujkov"


# create .dotnet-core-tools folder if not exists
if ! [ -d "$HOME/.dotnet-core-tools" ]
then
	mkdir -p "$HOME/.dotnet-core-tools"

	# get dotnet-install.sh script
	curl -sSL https://dot.net/v1/dotnet-install.sh > "$HOME/.dotnet-core-tools/dotnet-install.sh"

	# make the script executable
	chmod +x "$HOME/.dotnet-core-tools/dotnet-install.sh"

	# install .NET Core 8 and Latest SDKs if not installed
	if ! command -v dotnet &> /dev/null
	then
		"$HOME/.dotnet-core-tools/dotnet-install.sh" --channel Current --install-dir "$HOME/.dotnet-core-tools/"
		"$HOME/.dotnet-core-tools/dotnet-install.sh" --channel 8.0 --install-dir "$HOME/.dotnet-core-tools/"

	else echo ".NET Core is already installed, skipping"
	fi

	dotnet tool install csharpier --tool-path ~/.dotnet-core-tools


else echo ".dotnet-core-tools folder already exists, skipping"
fi

if ! [ -d "$HOME/.dotfiles/.config/LazyVim" ]
then
	# clone from lazy-vim branch of same repo
	gh repo clone dejanvujkov/dotfiles "$HOME/.dotfiles/.config/LazyVim/" -- --single-branch -b lazy-vim 

else echo "LazyVim is already installed, skipping"
fi
