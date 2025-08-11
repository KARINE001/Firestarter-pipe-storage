# 🚀 Quick Start Guide

## Prerequisites

- Linux system (Ubuntu 20.04+, Debian 11+, CentOS 8+)
- Root access (sudo)
- Stable internet connection
- 4GB+ RAM, 2+ CPU cores, 20GB+ free space

## Installation

### Option 1: One-Line Quick Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/install.sh | sudo bash
```

### Option 2: Manual Install with Steps

```bash
wget https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/manual-install.sh
chmod +x manual-install.sh
sudo ./manual-install.sh
```

## Post-Installation Setup

### 1. Switch to Firestarter User

```bash
sudo su - firestarter
```

### 2. Check Installation Status

```bash
./pipe-status.sh
```

### 3. Create Pipe Network Account

```bash
pipe new-user
```

Follow the prompts to create your username.

### 4. Get SOL DevNet Tokens

1. Get your Solana address:
   ```bash
   pipe check-token
   ```

2. Visit SOL DevNet Faucet: https://faucet.solana.com/

3. Enter your address (the "Pubkey" from step 1)

4. Request 1-2 SOL DevNet (free)

### 5. Swap SOL for PIPE Tokens

```bash
pipe swap-sol-for-pipe 0.1
```

### 6. Test Your Node

```bash
./pipe-test.sh
```

## First Operations

### Upload a File

```bash
echo "Hello Pipe Network!" > hello.txt
pipe upload-file hello.txt my-first-file
```

### Create Public Link

```bash
pipe create-public-link my-first-file
```

### Download a File

```bash
pipe download-file my-first-file downloaded.txt
```

### Upload with Encryption

```bash
pipe upload-file sensitive.txt secure-file --encrypt
```

## Discord Role

To get the Firestarter role:

1. Complete all operations above
2. Create public links to your files
3. Join Discord: https://discord.gg/pipenetwork
4. Post verification in #firestarter-verification channel

## Support

- GitHub Issues: https://github.com/karine001/Firestarter-pipe-node/issues
- Discord: https://discord.gg/pipenetwork
- Website: https://tokiostack.com
