#!/bin/bash

# ======================================================
# 🔥 PIPE FIRESTARTER - MANUAL INSTALL SCRIPT 🔥
# ======================================================
# Step-by-step guided installation for Pipe Network Firestarter Node
# Usage: sudo ./manual-install.sh
# ======================================================

set -e

# Script configuration
USERNAME="${USERNAME:-firestarter}"
INSTALL_DIR="${INSTALL_DIR:-/home/$USERNAME}"
SCRIPT_VERSION="v1.0.0"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Logging
log() { echo -e "${CYAN}[$(date +'%H:%M:%S')]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
ask() { echo -e "${BLUE}[INPUT]${NC} $1"; }

# Pause function for manual steps
pause() {
    echo ""
    echo -e "${YELLOW}Press ENTER to continue...${NC}"
    read -r
}

# Header
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║           🔥 PIPE FIRESTARTER MANUAL INSTALLER 🔥           ║
║                       TokioStack Edition                    ║
║                 Step-by-Step Installation                   ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

log "Welcome to the Manual Pipe Firestarter Installation ${SCRIPT_VERSION}"
echo ""
echo "This installer will guide you through each step with explanations."
echo "You can review each step before proceeding."
echo ""

# Root check
if [[ $EUID -ne 0 ]]; then
    error "This script must be run as root. Use: sudo ./manual-install.sh"
fi

pause

# ======================================================
# STEP 1: SYSTEM ANALYSIS
# ======================================================
echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                     STEP 1: SYSTEM ANALYSIS                ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

log "Analyzing your system..."

# OS Detection
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
    echo "✅ Operating System: $OS $VER"
else
    error "Cannot detect OS version. This installer supports Ubuntu 20.04+, Debian 11+, CentOS 8+"
fi

# Hardware check
CPU_CORES=$(nproc)
RAM_GB=$(free -g | awk 'NR==2{printf "%.1f", $2}')
DISK_GB=$(df -BG / | awk 'NR==2{print $4}' | sed 's/G//')

echo "✅ CPU Cores: $CPU_CORES"
echo "✅ RAM: ${RAM_GB}GB"
echo "✅ Free Disk: ${DISK_GB}GB"

# Requirements check
echo ""
echo "🔍 Checking system requirements:"

if [ "$CPU_CORES" -ge 2 ]; then
    echo "✅ CPU: $CPU_CORES cores (minimum: 2, recommended: 4+)"
else
    warning "CPU: $CPU_CORES cores (below minimum of 2)"
fi

if (( $(echo "$RAM_GB >= 4" | bc -l) )); then
    echo "✅ RAM: ${RAM_GB}GB (minimum: 4GB, recommended: 8GB+)"
else
    warning "RAM: ${RAM_GB}GB (below minimum of 4GB)"
fi

if [ "$DISK_GB" -ge 20 ]; then
    echo "✅ Disk: ${DISK_GB}GB free (minimum: 20GB, recommended: 50GB+)"
else
    warning "Disk: ${DISK_GB}GB free (below minimum of 20GB)"
fi

echo ""
ask "System analysis complete. Continue with installation? [Y/n]"
read -r CONTINUE
if [[ $CONTINUE =~ ^[Nn]$ ]]; then
    log "Installation cancelled by user"
    exit 0
fi

echo ""
echo "🚀 Proceeding with installation..."
echo "This script will now install all components automatically."
echo "You can interrupt at any time with Ctrl+C"

pause

# ======================================================
# AUTOMATIC INSTALLATION FROM HERE
# ======================================================
log "🔄 Starting automatic installation process..."

# Use the quick installer logic for the rest
# [Include the same installation steps as the quick installer]

# Package manager detection
if command -v apt >/dev/null 2>&1; then
    PKG_MANAGER="apt"
    UPDATE_CMD="apt update -y"
    INSTALL_CMD="apt install -y"
    PACKAGES="curl wget git build-essential pkg-config libssl-dev htop screen unzip ca-certificates jq"
elif command -v yum >/dev/null 2>&1; then
    PKG_MANAGER="yum"
    UPDATE_CMD="yum update -y"
    INSTALL_CMD="yum install -y"
    PACKAGES="curl wget git gcc gcc-c++ openssl-devel htop screen unzip ca-certificates"
else
    error "Unsupported package manager"
fi

# Install dependencies
log "📦 Installing dependencies..."
$UPDATE_CMD
$INSTALL_CMD $PACKAGES

# Create user
log "👤 Creating user account..."
if ! id "$USERNAME" &>/dev/null; then
    useradd -m -s /bin/bash "$USERNAME"
fi
usermod -aG sudo "$USERNAME" 2>/dev/null || usermod -aG wheel "$USERNAME" 2>/dev/null || true

# Install Rust
log "🦀 Installing Rust..."
sudo -u "$USERNAME" bash -c "
    export HOME=$INSTALL_DIR
    cd \$HOME
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source \$HOME/.cargo/env
    rustup update
"

# Install Pipe Network
log "🔥 Installing Pipe Network..."
sudo -u "$USERNAME" bash -c "
    export HOME=$INSTALL_DIR
    source \$HOME/.cargo/env
    cd \$HOME
    [ -d 'pipe' ] && rm -rf pipe
    git clone https://github.com/PipeNetwork/pipe.git
    cd pipe
    cargo install --path .
"

# Configure environment
log "⚙️ Configuring environment..."
sudo -u "$USERNAME" bash -c "
    export HOME=$INSTALL_DIR
    if ! grep -q 'source \$HOME/.cargo/env' \$HOME/.bashrc; then
        echo '' >> \$HOME/.bashrc
        echo '# Pipe Network Environment' >> \$HOME/.bashrc
        echo 'source \$HOME/.cargo/env' >> \$HOME/.bashrc
        echo 'export PATH=\"\$HOME/.cargo/bin:\$PATH\"' >> \$HOME/.bashrc
    fi
"

# Create helper scripts (same as quick installer)
log "📝 Creating helper scripts..."
sudo -u "$USERNAME" bash -c "
cat > $INSTALL_DIR/pipe-status.sh << 'EOFSTATUS'
#!/bin/bash
echo '🔥 Pipe Firestarter Status Check'
echo '==============================='
echo \"Date: \$(date)\"
echo \"User: \$(whoami)\"
echo \"\"

if command -v pipe >/dev/null 2>&1; then
    echo '✅ Pipe CLI: Available'
    pipe --version 2>/dev/null || echo '   Version check may require setup'
else
    echo '❌ Pipe CLI: Not available'
    echo '   Run: source ~/.cargo/env'
fi

if [ -f ~/.pipe-cli.json ]; then
    echo '✅ Configuration: Present'
else
    echo '❌ Configuration: Missing'
    echo '   Run: pipe new-user'
fi

echo \"\"
echo '💰 Token Status:'
pipe check-token 2>/dev/null || echo '   Not configured - run pipe new-user first'

echo \"\"
echo '🌐 Next Steps:'
echo '   1. Create user: pipe new-user'
echo '   2. Get SOL: https://faucet.solana.com/'
echo '   3. Swap tokens: pipe swap-sol-for-pipe 0.1'
echo '   4. Test: ./pipe-test.sh'
EOFSTATUS

chmod +x $INSTALL_DIR/pipe-status.sh
"

success "Manual installation completed successfully!"

echo ""
echo "🚀 NEXT STEPS:"
echo "==============="
echo "1. Switch user:    sudo su - $USERNAME"
echo "2. Check status:   ./pipe-status.sh"
echo "3. Create account: pipe new-user"
echo "4. Get SOL DevNet: https://faucet.solana.com/"
echo "5. Swap tokens:    pipe swap-sol-for-pipe 0.1"

log "🔥 Manual installation complete! 🚀"
