# 🔧 Troubleshooting Guide

## Common Issues

### 1. "pipe: command not found"

**Symptoms:**
```
bash: pipe: command not found
```

**Solutions:**
```bash
# Load Rust environment
source ~/.cargo/env

# Add to bashrc permanently
echo 'source $HOME/.cargo/env' >> ~/.bashrc

# Verify PATH
echo $PATH | grep -q cargo && echo "✅ Cargo in PATH" || echo "❌ Cargo not in PATH"
```

### 2. "Insufficient tokens"

**Symptoms:**
```
Upload failed: You need X PIPE tokens. You currently have 0 PIPE tokens.
```

**Solutions:**
```bash
# 1. Get SOL DevNet from faucet
# Visit: https://faucet.solana.com/
# Use address from: pipe check-token

# 2. Swap SOL for PIPE tokens
pipe swap-sol-for-pipe 0.1

# 3. Verify balance
pipe check-token
```

### 3. Compilation Errors

**Symptoms:**
```
error: could not compile 'pipe-cli'
error: linking with 'cc' failed
```

**Solutions:**
```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Install missing dependencies
sudo apt install -y build-essential pkg-config libssl-dev

# Update Rust toolchain
rustup update

# Clean and rebuild
cd ~/pipe
cargo clean
cargo install --path . --force
```

### 4. Permission Denied

**Symptoms:**
```
Permission denied (publickey)
fatal: Could not read from remote repository
```

**Solutions:**
```bash
# Check if running as correct user
whoami

# Switch to firestarter user
sudo su - firestarter

# Verify home directory permissions
ls -la /home/firestarter
```

### 5. Network Connectivity Issues

**Symptoms:**
```
Service discovery failed
Connection timeout
curl: (6) Could not resolve host
```

**Solutions:**
```bash
# Test basic connectivity
ping google.com

# Test Solana DevNet
ping api.devnet.solana.com

# Test Pipe Network endpoints
curl -s https://us-west-00-firestarter.pipenetwork.com/health

# Check firewall
sudo ufw status

# Temporarily disable firewall for testing
sudo ufw disable
# (Remember to re-enable: sudo ufw enable)
```

### 6. Rust Installation Issues

**Symptoms:**
```
rustc: command not found
cargo: command not found
```

**Solutions:**
```bash
# Reinstall Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Load environment
source ~/.cargo/env

# Verify installation
rustc --version
cargo --version

# Update if needed
rustup update
```

### 7. User Account Issues

**Symptoms:**
```
sudo: firestarter: command not found
User firestarter does not exist
```

**Solutions:**
```bash
# Check if user exists
id firestarter

# Create user manually if needed
sudo useradd -m -s /bin/bash firestarter

# Add to sudo group
sudo usermod -aG sudo firestarter

# Set password (optional)
sudo passwd firestarter
```

## Diagnostic Commands

### System Health Check

```bash
# Check system resources
df -h
free -m
uptime

# Check user configuration
whoami
pwd
echo $HOME
echo $PATH

# Check Pipe installation
which pipe
pipe --version
ls -la ~/.cargo/bin/pipe
```

### Pipe Network Diagnostics

```bash
# Check configuration
cat ~/.pipe-cli.json | jq '.'

# Check token balance
pipe check-token

# Test connectivity
pipe --help

# Check upload history
ls -la ~/.pipe-cli-uploads.json
```

### Log Analysis

```bash
# Check system logs
sudo journalctl -u systemd-networkd --since "1 hour ago"

# Check Rust compilation logs
cargo build 2>&1 | tee build.log

# Check pipe operation logs
pipe upload-file test.txt test 2>&1 | tee pipe.log
```

## Getting Help

### Before Asking for Help

1. Run diagnostic commands above
2. Check system requirements
3. Try the solutions in this guide
4. Search existing GitHub issues

### How to Report Issues

1. **Open GitHub Issue**: https://github.com/karine001/Firestarter-pipe-node/issues

2. **Include Information**:
   - Operating system and version
   - Error messages (full text)
   - Steps to reproduce
   - Output of diagnostic commands

3. **Use This Template**:
   ```
   **Environment:**
   - OS: Ubuntu 22.04
   - Architecture: x86_64
   - RAM: 8GB
   - Installation method: Quick install script

   **Issue:**
   Describe the problem clearly...

   **Error Output:**
   ```
   Paste error messages here
   ```

   **Steps to Reproduce:**
   1. Step one
   2. Step two
   3. Step three

   **Expected Behavior:**
   What should have happened...

   **Additional Context:**
   Any other relevant information...
   ```

### Community Support

- **Discord**: https://discord.gg/pipenetwork
- **Website**: https://tokiostack.com
- **Email**: support@tokiostack.com

## Complete Reinstallation

If all else fails, clean reinstall:

```bash
# 1. Uninstall completely
wget https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/uninstall.sh
chmod +x uninstall.sh
sudo ./uninstall.sh

# 2. Clean system
sudo apt autoremove -y
sudo apt autoclean

# 3. Reinstall fresh
curl -sSL https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/install.sh | sudo bash
```

---

**Still having issues? Don't hesitate to ask for help in our community!**
