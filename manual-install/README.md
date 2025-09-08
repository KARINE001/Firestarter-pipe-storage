# 🛠️ Manual Installation - Step by Step

> **Install Firestarter storage node manually with full understanding of each step**

## Why Manual Installation?

- 🧠 **Learn while installing** - understand what each step does
- 🔧 **Full control** - customize settings as needed
- 🔍 **Troubleshoot easily** - know exactly what went wrong
- 📚 **Educational** - become an expert operator

---

## 📋 Prerequisites Check

### System Requirements
```bash
# Check your system
lscpu | grep "CPU(s)"          # Should show 2+ cores
free -h | grep "Mem"           # Should show 4GB+ RAM
df -h | grep "/$"              # Should show 20GB+ free space
```

### Update System
```bash
sudo apt update && sudo apt upgrade -y
```

---

## 👤 Step 1: Create Dedicated User

### Why a dedicated user?
- **Security isolation** - separates node from your main account
- **Easier management** - all files in one place
- **Permission control** - limited access for safety

### Commands:
```bash
# Create user
sudo useradd -m -s /bin/bash firestarter

# Add to sudo group (for installation only)
sudo usermod -aG sudo firestarter

# Switch to new user
sudo su - firestarter
```

**✅ Checkpoint:** You should now see `firestarter@your-server:~$`

---

## 🦀 Step 2: Install Rust Programming Language

### Why Rust?
- **Pipe Network CLI** is written in Rust
- **Compile from source** ensures latest version
- **Security focused** language

### Commands:
```bash
# Download and install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Choose option 1 (default installation)
# Press Enter when prompted

# Load Rust environment
source ~/.cargo/env

# Verify installation
rustc --version
cargo --version
```

**✅ Checkpoint:** Should show Rust and Cargo versions

---

## 📦 Step 3: Install System Dependencies

### Why these packages?
- **build-essential** - compiling tools
- **libssl-dev** - SSL encryption support
- **pkg-config** - package configuration
- **git** - download source code

### Commands:
```bash
# Install dependencies
sudo apt install -y curl wget git build-essential pkg-config libssl-dev htop screen unzip ca-certificates jq
```

**✅ Checkpoint:** All packages installed without errors

---

## 🔥 Step 4: Download and Compile Pipe Network

### What we're doing:
- **Clone official repository** from GitHub
- **Compile from source** for security
- **Install CLI globally** for easy access

### Commands:
```bash
# Clone repository
git clone https://github.com/PipeNetwork/pipe.git
cd pipe

# Compile and install (this takes 5-10 minutes)
cargo install --path .

# Verify installation
~/.cargo/bin/pipe --version
```

**✅ Checkpoint:** Should show pipe CLI version

---

## ⚙️ Step 5: Environment Configuration

### Why configure environment?
- **Automatic PATH setup** - pipe command available everywhere
- **Persistent configuration** - survives reboots

### Commands:
```bash
# Add to shell configuration
echo '' >> ~/.bashrc
echo '# Pipe Network Environment' >> ~/.bashrc
echo 'source $HOME/.cargo/env' >> ~/.bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc

# Reload configuration
source ~/.bashrc

# Test pipe command (should work without full path)
pipe --version
```

**✅ Checkpoint:** `pipe --version` works without full path

---

## 🎯 Step 6: Create Your Pipe Network Account

### What this creates:
- **Unique user ID** for your account
- **Wallet address** for receiving tokens
- **Configuration file** with credentials

### Commands:
```bash
# Create account
pipe new-user

# Follow prompts:
# - Enter username (e.g., "john-firestarter")
# - Confirm creation
```

**✅ Checkpoint:** Creates `~/.pipe-cli.json` config file

---

## 💰 Step 7: Get Your Wallet Address

### Commands:
```bash
# Get wallet information
pipe check-token
```

**Expected output:**
```
Token Balance for user: [your-user-id]
Pubkey: [your-solana-address]
Mint: 35mhJor7qTD212YXdLkB8sRzTbaYRXmTzHTCFSDP5voJ
Amount: 0
```

**📝 Copy the "Pubkey" address** - you need it for the next step!

---

## 🚰 Step 8: Fund Your Wallet with DevNet SOL

### Why DevNet SOL?
- **Completely free** - no real money needed
- **Testing network** - safe to experiment
- **Required for operations** - pays for network fees

### Steps:
1. **Visit**: https://faucet.solana.com/
2. **Paste your Pubkey** from Step 7
3. **Request 1 SOL DevNet** (click button)
4. **Wait 30 seconds** for confirmation

### Verify funding:
```bash
pipe check-token
```
**Should now show SOL balance**

---

## 🔄 Step 9: Swap SOL for PIPE Tokens

### Why swap?
- **PIPE tokens** pay for storage operations
- **Very cheap** - 0.1 SOL = 1 PIPE = ~1000 file uploads

### Commands:
```bash
# Swap 0.1 SOL for PIPE tokens
pipe swap-sol-for-pipe 0.1

# Verify balance
pipe check-token
```

**Expected output:**
```
Swap SOL -> PIPE complete!
SOL spent: 0.1
PIPE minted: 1
```

---

## 🧪 Step 10: Test Everything

### Create test file:
```bash
echo "Hello from my Firestarter node! $(date)" > test.txt
```

### Upload test:
```bash
pipe upload-file test.txt my-first-upload
```

### Verify success:
```bash
# Should show successful upload with cost
```

**✅ Final Checkpoint:** Upload successful = Installation complete!

---

## 🎮 Next Steps: Complete Operations

**Perfect! Now continue to:** [Complete Operations Guide](../operations/) to learn all file operations and get your Discord role!

---

## 🔧 Troubleshooting

### Build errors during compilation
```bash
# Update Rust
rustup update

# Clean and retry
cd ~/pipe
cargo clean
cargo install --path . --force
```

### Permission errors
```bash
# Make sure you're the firestarter user
whoami  # should show "firestarter"

# Check file permissions
ls -la ~/.pipe-cli.json
```

### Network errors
```bash
# Test connectivity
ping api.devnet.solana.com
curl -s https://us-west-00-firestarter.pipenetwork.com/health
```

---

**🔥 Manual Installation Complete! Ready for operations! 🔥**
