#!/bin/bash

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="simple-pki"
REPO_URL="https://raw.githubusercontent.com/nimish-ks/simple-pki/main/simple-pki"

# Colors
GREEN='\033[0;32m'
NC='\033[0m'

echo "Installing simple-pki..."

# Create install directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
    echo "Created directory $INSTALL_DIR"
fi

# Download the script
echo "Downloading script from GitHub..."
# Note: In a real scenario, this would curl from the repo. 
# Since I am generating the script locally in this environment, 
# I will simulate the install by copying the local file if it exists, 
# otherwise I'll put the curl command for the user's actual usage.

# Using curl to download (commented out for local dev, but enabled for final script)
curl -sL "$REPO_URL" -o "$INSTALL_DIR/$SCRIPT_NAME" || {
    # Fallback for this environment if curl fails (e.g. repo doesn't exist yet)
    if [ -f "./simple-pki" ]; then
        echo "Using local simple-pki script..."
        cp "./simple-pki" "$INSTALL_DIR/$SCRIPT_NAME"
    else
        echo "Error: Could not download script and local file not found."
        exit 1
    fi
}

# Make executable
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

echo -e "${GREEN}Successfully installed to $INSTALL_DIR/$SCRIPT_NAME${NC}"

# Check PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "Warning: $INSTALL_DIR is not in your PATH."
    echo "Add the following line to your shell configuration file (.bashrc, .zshrc, etc.):"
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
else
    echo "You can now run 'simple-pki' from your terminal."
fi

