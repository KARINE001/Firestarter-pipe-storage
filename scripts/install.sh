#!/bin/bash

# ======================================================
# 🔥 PIPE FIRESTARTER - QUICK INSTALL SCRIPT 🔥
# ======================================================
# One-line automated installation for Pipe Network Firestarter Node
# Usage: curl -sSL https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/install.sh | sudo bash
# ======================================================

set -e

# Script configuration
USERNAME="${USERNAME:-firestarter}"
INSTALL_DIR="${INSTALL_DIR:-/home/$USERNAME}"
SCRIPT_VERSION="v1.0.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Logging functions
log() { echo -e "${CYAN}[$(date +'%H:%M:%S')]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Header
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║            🔥 PIPE FIRESTARTER QUICK INSTALLER 🔥            ║
║                       TokioStack Edition                    ║
║                   Node Operations Made Easy                 ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

log "Starting Pipe Firestarter installation ${SCRIPT_VERSION}"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    error "This script must be run as root. Use: curl -sSL [script-url] | sudo bash"
fi

# ======================================================
# SYSTEM DETECTION AND PREPARATION
# ======================================================
log "🔍 Detecting system..."

# OS Detection
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
    log "Detected: $OS $VER"
else
    error "Cannot detect OS. Supported: Ubuntu 20.04+, Debian 11+, CentOS 8+"
fi

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
    error "Unsupported package manager. This script supports apt (Ubuntu/Debian) and yum (CentOS/RHEL)"
fi

success "System detection complete: $PKG_MANAGER"

# ======================================================
# SYSTEM UPDATE AND DEPENDENCIES
# ======================================================
log "📦 Installing system dependencies..."

$UPDATE_CMD
$INSTALL_CMD $PACKAGES

# Install jq on CentOS/RHEL (not in default repos)
if [[ "$PKG_MANAGER" == "yum" ]] && ! command -v jq >/dev/null 2>&1; then
    log "Installing jq for CentOS..."
    wget -O /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
    chmod +x /usr/bin/jq
fi

success "Dependencies installed successfully"

# ======================================================
# USER ACCOUNT SETUP
# ======================================================
log "👤 Setting up user account..."

if id "$USERNAME" &>/dev/null; then
    warning "User $USERNAME already exists"
else
    useradd -m -s /bin/bash "$USERNAME"
    success "User $USERNAME created"
fi

# Add to sudo group
usermod -aG sudo "$USERNAME" 2>/dev/null || usermod -aG wheel "$USERNAME" 2>/dev/null || true

success "User account configured"

# ======================================================
# RUST INSTALLATION
# ======================================================
log "🦀 Installing Rust toolchain..."

sudo -u "$USERNAME" bash -c "
    export HOME=$INSTALL_DIR
    cd \$HOME
    
    # Install Rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    
    # Load environment
    source \$HOME/.cargo/env
    
    # Update and verify
    rustup update
    rustc --version
    cargo --version
"

success "Rust toolchain installed"

# ======================================================
# PIPE NETWORK INSTALLATION
# ======================================================
log "🔥 Installing Pipe Network CLI..."

sudo -u "$USERNAME" bash -c "
    export HOME=$INSTALL_DIR
    source \$HOME/.cargo/env
    cd \$HOME
    
    # Remove existing installation
    [ -d 'pipe' ] && rm -rf pipe
    
    # Clone and build
    git clone https://github.com/PipeNetwork/pipe.git
    cd pipe
    cargo install --path .
    
    # Verify installation
    \$HOME/.cargo/bin/pipe --version
"

success "Pipe Network CLI installed"

# ======================================================
# ENVIRONMENT CONFIGURATION
# ======================================================
log "⚙️ Configuring environment..."

sudo -u "$USERNAME" bash -c "
    export HOME=$INSTALL_DIR
    
    # Update bashrc
    if ! grep -q 'source \$HOME/.cargo/env' \$HOME/.bashrc; then
        echo '' >> \$HOME/.bashrc
        echo '# Pipe Network Environment' >> \$HOME/.bashrc
        echo 'source \$HOME/.cargo/env' >> \$HOME/.bashrc
        echo 'export PATH=\"\$HOME/.cargo/bin:\$PATH\"' >> \$HOME/.bashrc
    fi
"

success "Environment configured"

# ======================================================
# HELPER SCRIPTS CREATION
# ======================================================
log "📝 Creating helper scripts..."

# Status check script
sudo -u "$USERNAME" bash -c "
cat > $INSTALL_DIR/pipe-status.sh << 'EOFSTATUS'
#!/bin/bash
echo '🔥 Pipe Firestarter Status Check'
echo '==============================='
echo \"Date: \$(date)\"
echo \"User: \$(whoami)\"
echo \"\"

# Check pipe command
if command -v pipe >/dev/null 2>&1; then
    echo '✅ Pipe CLI: Available'
    pipe --version 2>/dev/null || echo '   Version check may require setup'
else
    echo '❌ Pipe CLI: Not available'
    echo '   Run: source ~/.cargo/env'
fi

# Check configuration
if [ -f ~/.pipe-cli.json ]; then
    echo '✅ Configuration: Present'
else
    echo '❌ Configuration: Missing'
    echo '   Run: pipe new-user'
fi

# Check balance (will fail if not configured)
echo \"\"
echo '💰 Token Status:'
pipe check-token 2>/dev/null || echo '   Not configured - run pipe new-user first'

echo \"\"
echo '📊 System Resources:'
echo \"   Disk: \$(df -h ~ | tail -1 | awk '{print \$4}') available\"
echo \"   RAM: \$(free -m | grep Mem | awk '{print \$7}')MB available\"

echo \"\"
echo '🌐 Next Steps:'
echo '   1. Create user: pipe new-user'
echo '   2. Get SOL: https://faucet.solana.com/'
echo '   3. Swap tokens: pipe swap-sol-for-pipe 0.1'
echo '   4. Test: ./pipe-test.sh'
EOFSTATUS

chmod +x $INSTALL_DIR/pipe-status.sh
"

# Quick test script
sudo -u "$USERNAME" bash -c "
cat > $INSTALL_DIR/pipe-test.sh << 'EOFTEST'
#!/bin/bash
echo '🧪 Pipe Firestarter Quick Test'
echo '============================='

# Prerequisites check
if ! command -v pipe >/dev/null 2>&1; then
    echo '❌ Pipe CLI not available. Run: source ~/.cargo/env'
    exit 1
fi

if [ ! -f ~/.pipe-cli.json ]; then
    echo '❌ No configuration found. Run: pipe new-user'
    exit 1
fi

# Create and upload test file
TEST_FILE=\"test-\$(date +%s).txt\"
echo \"Hello from Pipe Network! Test at \$(date)\" > \"\$TEST_FILE\"

echo '📤 Testing file upload...'
if pipe upload-file \"\$TEST_FILE\" \"test-\$(date +%s)\"; then
    echo '✅ Upload test successful!'
    echo '🎉 Your Firestarter node is working perfectly!'
else
    echo '❌ Upload failed. Common issues:'
    echo '   - No PIPE tokens (run: pipe swap-sol-for-pipe 0.1)'
    echo '   - Network connectivity'
    echo '   - Account not properly configured'
fi

# Cleanup
rm -f \"\$TEST_FILE\"

echo \"\"
echo '�� Useful commands:'
echo '   pipe check-token          - Check balance'
echo '   pipe create-public-link   - Create shareable links'
echo '   pipe upload-directory     - Upload folders'
EOFTEST

chmod +x $INSTALL_DIR/pipe-test.sh
"

success "Helper scripts created"

# ======================================================
# FINAL VERIFICATION
# ======================================================
log "🔍 Running final verification..."

# Test basic functionality
sudo -u "$USERNAME" bash -c "
    export HOME=$INSTALL_DIR
    source \$HOME/.cargo/env
    
    # Test pipe command
    if \$HOME/.cargo/bin/pipe --version >/dev/null 2>&1; then
        echo '✅ Pipe CLI is functional'
    else
        echo '❌ Pipe CLI test failed'
        exit 1
    fi
"

success "Installation verification passed"

# ======================================================
# SUCCESS MESSAGE
# ======================================================
echo ""
echo -e "${GREEN}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                   🎉 INSTALLATION COMPLETE! 🎉              ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo "📋 INSTALLATION SUMMARY:"
echo "========================"
echo "✅ User created: $USERNAME"
echo "✅ Rust & Cargo installed"
echo "✅ Pipe Network CLI ready"
echo "✅ Helper scripts available"
echo "✅ Environment configured"
echo ""

echo "🚀 QUICK START:"
echo "==============="
echo "1. Switch user:    sudo su - $USERNAME"
echo "2. Check status:   ./pipe-status.sh"
echo "3. Create account: pipe new-user"
echo "4. Get SOL DevNet: https://faucet.solana.com/"
echo "5. Swap tokens:    pipe swap-sol-for-pipe 0.1"
echo "6. Run test:       ./pipe-test.sh"
echo ""

echo "📚 RESOURCES:"
echo "============="
echo "📖 Full Guide: https://tokiostack.com/guides/pipe-firestarter"
echo "💬 Discord: https://discord.gg/pipenetwork"
echo "💰 SOL Faucet: https://faucet.solana.com/"
echo "🆘 Support: https://github.com/karine001/Firestarter-pipe-node/issues"
echo ""

log "🔥 Pipe Firestarter node ready! Happy storing! 🚀"
