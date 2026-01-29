OS_TYPE="mac"
PKG_INSTALL="brew install"

brew_install () {
    # TODO: Test if homebrew already is installed.
    HOMEBREW_NO_INSTALL_FROM_API=1
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo installs brew here
}