# 🚀 Quick Start - Automated Installation

> **Get your Firestarter storage node running in 5 minutes with full automation**

## ⚡ One-Command Installation

```bash
curl -sSL https://raw.githubusercontent.com/karine001/Firestarter-pipe-storage/main/scripts/install.sh | sudo bash
```

**What this does:**
- ✅ Creates dedicated `firestarter` user
- ✅ Installs Rust + dependencies
- ✅ Compiles Pipe Network CLI
- ✅ Sets up environment
- ✅ Creates helper scripts

**Expected output:**
```
🔥 PIPE FIRESTARTER QUICK INSTALLER 🔥
[15:23:15] Starting installation...
[15:25:42] ✅ Installation complete!
```

---

## 🔧 After Installation - Complete Setup

### Step 1: Switch to Firestarter User
```bash
sudo su - firestarter
```

### Step 2: Create Your Account
```bash
pipe new-user
```
- Enter a username (suggestion: `your-name-firestarter`)
- Confirm account creation

### Step 3: Get Your Wallet Address
```bash
pipe check-token
```
**Copy the "Pubkey" address** - you'll need it for the faucet.

### Step 4: Fund Your Wallet
1. **Visit SOL DevNet Faucet**: https://faucet.solana.com/
2. **Paste your Pubkey address** from Step 3
3. **Request 1 SOL DevNet** (free)
4. **Wait ~30 seconds** for confirmation

### Step 5: Swap SOL for PIPE Tokens
```bash
pipe swap-sol-for-pipe 0.1
```
**Expected output:**
```
Swap SOL -> PIPE complete!
SOL spent: 0.1
PIPE minted: 1
```

### Step 6: Verify Everything Works
```bash
./pipe-test.sh
```

---

## 🎮 Next Steps: Complete Operations

**Now continue to:** [Complete Operations Guide](../operations/) to learn all file operations and get your Discord role!

---

## 🔧 Troubleshooting

### "pipe: command not found"
```bash
source ~/.cargo/env
```

### "Insufficient tokens"
```bash
# Get more SOL from faucet, then:
pipe swap-sol-for-pipe 0.1
```

### Installation failed
```bash
# Try manual installation instead
```
**Go to:** [Manual Installation](../manual-install/)

---

**🔥 Quick Start Complete! Ready for operations! 🔥**
