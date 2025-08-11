#!/bin/bash

# ======================================================
# 🔥 PIPE FIRESTARTER - UNINSTALL SCRIPT 🔥
# ======================================================
# Clean removal of Pipe Network Firestarter Storage
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

echo -e "${YELLOW}WARNING: This will completely remove the Firestarter storage installation.${NC}"
echo ""
echo "This will remove:"
echo "- User account: $USERNAME"
echo "- All uploaded files and configuration"
echo "- Rust toolchain (if installed only for this)"
echo "- All helper scripts and data"
echo ""
read -p "Are you sure you want to uninstall? [y/N]: " -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

echo ""
echo "🗑️ Removing Firestarter storage installation..."

# Remove user account and home directory
if id "$USERNAME" &>/dev/null; then
    echo "Removing user account: $USERNAME"
    userdel -r "$USERNAME" 2>/dev/null || {
        echo "⚠️ User removal failed - trying manual cleanup"
        
        # Kill any processes owned by user
        pkill -u "$USERNAME" 2>/dev/null || true
        
        # Wait a moment
        sleep 2
        
        # Try again
        userdel -r "$USERNAME" 2>/dev/null || {
            echo "⚠️ Manual cleanup required:"
            echo "   sudo userdel $USERNAME"
            echo "   sudo rm -rf /home/$USERNAME"
        }
    }
    echo "✅ User account removed"
else
    echo "ℹ️ User $USERNAME not found"
fi

# Remove any remaining files
echo "Cleaning up remaining files..."
rm -rf "/home/$USERNAME" 2>/dev/null || true

# Remove from sudo group references
if [ -f /etc/sudoers.d/$USERNAME ]; then
    rm -f /etc/sudoers.d/$USERNAME
fi

echo ""
echo -e "${GREEN}✅ Uninstall completed successfully!${NC}"
echo ""
echo "📝 Notes:"
echo "- System packages (rust, git, etc.) were left installed"
echo "- They may be used by other applications"
echo "- Remove manually if desired: sudo apt remove rust-all git build-essential"
echo ""
echo "🔄 To reinstall:"
echo "   curl -sSL https://raw.githubusercontent.com/karine001/Firestarter-pipe-storage/main/scripts/install.sh | sudo bash"
echo ""
echo "🆘 Need help? Visit: https://github.com/karine001/Firestarter-pipe-storage/issues"
