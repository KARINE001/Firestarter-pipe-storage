# 🎮 Complete Operations Guide

> **Master all Firestarter storage operations and get ready for your Discord role**

## 📋 Prerequisites

- ✅ Firestarter node installed ([Quick Start](../quick-start/) or [Manual](../manual-install/))
- ✅ User account created with `pipe new-user`
- ✅ Wallet funded with SOL DevNet
- ✅ SOL swapped for PIPE tokens

**Check your status:**
```bash
pipe check-token
# Should show PIPE token balance > 0
```

---

## 📤 File Upload Operations

### 1. Upload Single File
```bash
# Create test file
echo "Hello from Pipe Network! $(date)" > hello.txt

# Upload file
pipe upload-file hello.txt my-hello-file

# Expected output:
# ✅ File uploaded successfully: my-hello-file
# 💰 Cost: 0.000000069 PIPE tokens
```

### 2. Upload Image/Photo
```bash
# Upload any image (replace with your file)
pipe upload-file photo.jpg my-photo-$(date +%s)

# Cost: ~0.005 PIPE tokens for 5MB photo
```

### 3. Upload with Encryption
```bash
# Upload encrypted file
pipe upload-file sensitive.pdf secure-document --encrypt

# You'll be prompted for password:
# Enter encryption password: [type password]
# Confirm encryption password: [type same password]

# IMPORTANT: Remember this password - you'll need it to decrypt!
```

### 4. Upload Directory
```bash
# Create test directory
mkdir test-folder
echo "File 1" > test-folder/file1.txt
echo "File 2" > test-folder/file2.txt

# Upload entire directory
pipe upload-directory test-folder

# All files uploaded individually
```

---

## 🔗 Create Public Download Links

### Why Public Links?
- **Share files easily** - anyone can download
- **Required for Discord role** - must demonstrate this
- **No authentication needed** - direct access

### Commands:
```bash
# Create public link for any uploaded file
pipe create-public-link my-hello-file

# Expected output:
# ✅ Public link created successfully!
# 
# Direct link (for downloads):
# https://us-west-00-firestarter.pipenetwork.com/publicDownload?hash=abc123
# 
# Social media link (for sharing):
# https://us-west-00-firestarter.pipenetwork.com/publicDownload?hash=abc123&preview=true
```

### Test Your Links:
1. **Copy the direct link**
2. **Open in browser** (or share with friends)
3. **File should download** directly

---

## 📥 Download Operations

### 1. Download Your Files
```bash
# Download file you uploaded
pipe download-file my-hello-file downloaded-hello.txt

# Check content
cat downloaded-hello.txt
```

### 2. Download and Decrypt
```bash
# Download encrypted file
pipe download-file secure-document decrypted.pdf --decrypt

# Enter decryption password when prompted
# Same password you used for encryption
```

---

## 🔧 Advanced Operations

### 1. Local Encryption (without uploading)
```bash
# Encrypt file locally
pipe encrypt-local document.pdf document.pdf.enc

# File encrypted but not uploaded yet
```

### 2. Generate Encryption Keys
```bash
# Generate AES-256 key
pipe key-gen --name my-key --algorithm aes256

# Generate quantum-resistant key
pipe key-gen --name quantum-key --algorithm kyber1024

# List all keys
pipe key-list
```

### 3. File Information
```bash
# Get file details
pipe file-info my-hello-file

# Shows: encryption status, metadata
```

---

## 💰 Cost Analysis

### Understanding Costs
| **File Type** | **Size** | **PIPE Cost** | **Real World Example** |
|---------------|----------|---------------|------------------------|
| Text file | 1KB | 0.000000069 | Tweet, note |
| Photo | 5MB | 0.005 | Phone camera photo |
| Document | 10MB | 0.01 | PDF, presentation |
| Video | 100MB | 0.1 | Short video clip |

### Check Your Usage
```bash
# Check current balance
pipe check-token

# View usage breakdown
pipe token-usage
```

---

## 🏆 Discord Role Preparation

### Required Evidence for Firestarter Role

You need to collect these for Discord verification:

#### 1. User Information
```bash
pipe check-token
```
**Copy:**
- User ID: `[your-user-id-from-pipe-check-token]`
- Pubkey: `[your-solana-address]`

#### 2. Upload Evidence
**Upload at least 3 different file types:**
- [ ] Text file: `pipe upload-file hello.txt text-demo`
- [ ] Image file: `pipe upload-file photo.jpg image-demo`  
- [ ] Encrypted file: `pipe upload-file secret.txt encrypted-demo --encrypt`

#### 3. Public Links
**Create public links for each:**
```bash
pipe create-public-link text-demo
pipe create-public-link image-demo
pipe create-public-link encrypted-demo
```

**Save all 3 public URLs** - you'll post these in Discord!

#### 4. Operation Proof
**Create a summary of your operations:**
```bash
echo "=== My Firestarter Operations ===" > operations-summary.txt
echo "Date: $(date)" >> operations-summary.txt
echo "User ID: $(pipe check-token | grep 'user:' | awk '{print $4}')" >> operations-summary.txt
echo "Files uploaded: text, image, encrypted" >> operations-summary.txt
echo "Public links created: 3" >> operations-summary.txt
echo "Total cost: ~0.015 PIPE tokens" >> operations-summary.txt

# Upload this summary too
pipe upload-file operations-summary.txt my-firestarter-proof
```

---

## 📝 Discord Verification Template

**Copy this template and fill in your details:**

```markdown
🔥 **FIRESTARTER NODE VERIFICATION**

**Node Information:**
- User ID: [your-user-id-from-pipe-check-token]
- Wallet: [your-pubkey-address]
- Date: [current-date]

**✅ Operations Completed:**
✅ Node installed and configured
✅ User account created and wallet funded
✅ File uploads: text, image, encrypted
✅ Public links created and tested
✅ Download and decryption verified

**🔗 Public Download Links:**
1. **Text Demo**: https://us-west-00-firestarter.pipenetwork.com/publicDownload?hash=[hash1]
2. **Image Demo**: https://us-west-00-firestarter.pipenetwork.com/publicDownload?hash=[hash2]  
3. **Encrypted Demo**: https://us-west-00-firestarter.pipenetwork.com/publicDownload?hash=[hash3]

**💰 Token Usage:**
- Swapped: 0.1 SOL → 1 PIPE
- Used: ~0.015 PIPE for demonstrations
- Remaining: ~0.985 PIPE

Ready for Firestarter role! 🚀

#PipeNetwork #Firestarter #TokioStack
```

---

## 🎯 Next Steps: Get Your Role

**Now go to:** [Discord Roles Guide](../discord-roles/) to submit your verification and get the Firestarter role!

---

## 🔧 Troubleshooting Operations

### Upload fails
```bash
# Check balance
pipe check-token

# Need more tokens?
pipe swap-sol-for-pipe 0.1
```

### Public link creation fails
```bash
# Verify file was uploaded successfully
pipe file-info [filename]

# Try creating link again
pipe create-public-link [filename]
```

### Download fails
```bash
# Check exact filename
# Case sensitive!
pipe download-file [exact-stored-name] [local-output-name]
```

---

**🔥 Operations Mastered! Ready for Discord role! 🔥**
