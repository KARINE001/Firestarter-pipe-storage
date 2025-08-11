# 🔥 Pipe Network Firestarter Node

Complete automation scripts for installing and managing Pipe Network Firestarter nodes on Linux systems.

## 🚀 Quick Installation (Recommended)

**One-line installation** - automatically handles everything:

```bash
curl -sSL https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/install.sh | sudo bash
```

## 🛠️ Manual Installation

**Step-by-step installation** - full control over each step:

```bash
# Download the manual installer
wget https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/manual-install.sh

# Make it executable
chmod +x manual-install.sh

# Run with guided steps
sudo ./manual-install.sh
```

## 📋 What Gets Installed

- ✅ **Dedicated user account** (`firestarter`) for security isolation
- ✅ **Rust toolchain** with Cargo package manager
- ✅ **Pipe Network CLI** compiled from official source
- ✅ **System dependencies** (build tools, SSL, etc.)
- ✅ **Helper scripts** for status checking and testing
- ✅ **Environment configuration** for seamless usage

## 🖥️ System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| **OS** | Ubuntu 20.04+ | Ubuntu 22.04 LTS |
| **CPU** | 2 cores | 4 cores |
| **RAM** | 4GB | 8GB |
| **Storage** | 20GB free | 50GB SSD |
| **Network** | Stable internet | 100Mbps+ |

## ⚡ Quick Start After Installation

1. **Switch to firestarter user:**
   ```bash
   sudo su - firestarter
   ```

2. **Check installation status:**
   ```bash
   ./pipe-status.sh
   ```

3. **Create Pipe Network account:**
   ```bash
   pipe new-user
   ```

4. **Get SOL DevNet tokens:**
   - Visit: https://faucet.solana.com/
   - Use address from: `pipe check-token`

5. **Swap for PIPE tokens:**
   ```bash
   pipe swap-sol-for-pipe 0.1
   ```

6. **Test your node:**
   ```bash
   ./pipe-test.sh
   ```

## 📚 Documentation

- [📖 Quick Start Guide](docs/quick-start.md)
- [🔧 Troubleshooting](docs/troubleshooting.md)
- [💬 Discord Roles Guide](https://tokiostack.com/guides/pipe-firestarter)

## 🆘 Support & Community

- **🐛 Issues**: [GitHub Issues](https://github.com/karine001/Firestarter-pipe-node/issues)
- **💬 Discord**: [Pipe Network Community](https://discord.gg/pipenetwork)
- **📧 Email**: support@tokiostack.com
- **🌐 Website**: [TokioStack.com](https://tokiostack.com)

## 🔧 Advanced Usage

### Uninstallation

```bash
# Remove everything cleanly
wget https://raw.githubusercontent.com/karine001/Firestarter-pipe-node/main/scripts/uninstall.sh
chmod +x uninstall.sh
sudo ./uninstall.sh
```

### Custom Configuration

```bash
# Install to custom directory
sudo INSTALL_DIR=/opt/pipe ./install.sh

# Install for specific user
sudo USERNAME=custom-user ./install.sh
```

## 🤝 Contributing

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🌟 Star History

If this project helped you, please consider giving it a ⭐ star on GitHub!

---

**🔥 Built with ❤️ by [TokioStack](https://tokiostack.com) - Node Operations Made Easy 🔥**
