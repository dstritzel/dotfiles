if [ -f /etc/os-release ]; then
. /etc/os-release
if echo "$ID" | grep -q "ubuntu"; then
    echo "Running on Ubuntu"
    OS_TYPE="ubuntu"
    TAGS="$TAGS ubuntu"
    PKG_INSTALL="apt-get install -y"
fi
if echo "$ID" | grep -q "fedora"; then
    echo "Running on Fedora"
    OS_TYPE="fedora"
    TAGS="$TAGS fedora"
    PKG_INSTALL="dnf install -y"
    fi
fi