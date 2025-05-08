#!/usr/bin/env sh

set -e

# use temporary directory for download
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

NVIM_PATH="/usr/local/bin/nvim"

for path in /usr/bin/nvim /usr/local/bin/nvim; do
    if [ -f "$path" ]; then
        echo "Removing existing Neovim at $path"
        sudo rm -f "$path"
    fi
done

cd "$TMP_DIR"
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
if [ ! -f nvim-linux-x86_64.appimage ]; then
    echo "Download failed!" >&2
    exit 1
fi

chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage "$NVIM_PATH"
rm nvim-linux-x86_64.appimage

echo "Neovim installed successfully:"
$NVIM_PATH --version | head -n 1
