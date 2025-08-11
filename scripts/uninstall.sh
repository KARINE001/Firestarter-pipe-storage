#!/bin/bash

# ======================================================
# 🔥 PIPE FIRESTARTER - UNINSTALL SCRIPT 🔥
# ======================================================
# Clean removal of Pipe Network Firestarter Node
# Usage: sudo ./uninstall.sh
# ======================================================

set -e

USERNAME="${USERNAME:-firestarter}"
PURPLE='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║            🔥 PIPE FIRESTARTER UNINSTALLER 🔥               ║
║                    Clean Removal Tool                       ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Root check
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[ERROR]${NC} This script must be run as root. Use: sudo ./uninstall.sh"
    exit 1
fi

echo -e "${YELLOW}WARNING: This will completely remove the Firestarter node installation.${NC}"
echo ""
read -p "Are you sure you want to uninstall? [y/N]: " -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

echo ""
echo "🗑️ Removing Firestarter node installation..."

# Remove user account
if id "$USERNAME" &>/dev/null; then
    echo "Removing user account: $USERNAME"
            userdel -r "$USERNAME" 2>/dev/null || {
        echo "⚠️ User removal failed - may need manual cleanup"
        echo "   Home directory: /home/$USERNAME"
    }
    echo "✅ User account removed"
else
    echo "ℹ️ User $USERNAME not found"
fi

# Remove any remaining files
echo "Cleaning up remaining files..."
rm -rf "/home/$USERNAME" 2>/dev/null || true

echo ""
echo -e "${GREEN}✅ Uninstall completed successfully!${NC}"
echo ""
echo "🔄 To reinstall:"
echo "   curl -sSL https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/install.sh | sudo bash"
