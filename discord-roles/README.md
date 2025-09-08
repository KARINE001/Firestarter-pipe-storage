# 🏆 Discord Roles Guide

> **Get your Firestarter role and progress to OG status**

## 🎯 Current Goal: Firestarter Role

### Prerequisites Checklist
- [ ] Firestarter storage node installed and running
- [ ] User account created and wallet funded  
- [ ] Completed file operations (upload, encrypt, public links)
- [ ] Public download links ready to share

**Not done yet?** Complete the [Operations Guide](../operations/) first.

---

## 🔥 Firestarter Role Requirements

### Official Requirements (from Discord):
> "For the Firestarter role, you need to run a Firestarter node, perform actions such as uploading, downloading, encrypting, and decrypting data. Then, create public links to your uploaded data and share them in the #firestarter-verification channel for verification."

### Translation - What You Actually Need:

#### 1. ✅ Technical Proof
- **Node running** - Firestarter storage node operational
- **Operations completed** - Upload, download, encrypt, decrypt
- **Public links** - Shareable URLs to your uploaded files

#### 2. ✅ Community Verification  
- **Discord membership** - Join Pipe Network Discord
- **Post verification** - Share proof in #firestarter-verification
- **Wait for approval** - Mods will verify and grant role

---

## 📝 Preparing Your Verification Post

### 1. Gather Required Information

**Run these commands to collect info:**
```bash
# Get your account details
pipe check-token

# Copy these values:
# - User ID: [your-user-id-from-pipe-check-token]
# - Pubkey: [your-solana-address]
```

### 2. Ensure You Have Public Links

**You should have created at least 3 public links:**
```bash
# Create if you haven't already
pipe create-public-link [your-text-file]
pipe create-public-link [your-image-file]  
pipe create-public-link [your-encrypted-file]
```

### 3. Test Your Links
- **Click each public link** to verify they work
- **Download should start** automatically
- **Share with a friend** to double-check

---

## 🚀 Submit Your Verification

### Step 1: Join Discord
**Link:** https://discord.gg/pipenetwork

### Step 2: Find the Channel
Navigate to: **#firestarter-verification**

### Step 3: Post Verification
**Use this exact template:**

```markdown
🔥 **FIRESTARTER NODE VERIFICATION**

**Node Information:**
- User ID: `[paste-your-user-id-here]`
- Wallet Address: `[paste-your-pubkey-here]`
- Installation Date: [today's-date]
- Installation Method: [Quick Start / Manual Install]

**✅ Operations Completed:**
✅ Firestarter storage node installed and operational
✅ User account created and wallet funded with DevNet SOL
✅ File upload operations: text files, images, encrypted files
✅ File download and decryption operations verified
✅ Public download links created and tested

**🔗 Public Download Links (Click to test):**
1. **Text File Demo**: https://us-west-00-firestarter.pipenetwork.com/publicDownload?hash=[your-hash-1]
2. **Image File Demo**: https://us-west-00-firestarter.pipenetwork.com/publicDownload?hash=[your-hash-2]
3. **Encrypted File Demo**: https://us-west-00-firestarter.pipenetwork.com/publicDownload?hash=[your-hash-3]

**💰 Token Economics Proof:**
- Initial swap: 0.1 SOL DevNet → 1 PIPE token
- Operations cost: ~0.015 PIPE tokens for demonstrations
- Remaining balance: ~0.985 PIPE tokens

**🛠️ Technical Details:**
- OS: [Ubuntu 22.04 LTS / your-OS]
- Node uptime: [check-uptime]
- Storage operations: All successful
- Network connectivity: Verified

**Ready for Firestarter role verification! 🚀**

Built with TokioStack automation tools.
#PipeNetwork #Firestarter #DecentralizedStorage #TokioStack
```

### Step 4: Wait for Verification
- **Moderators will review** your submission
- **May ask questions** or request additional proof
- **Role granted** once verified (usually within 24 hours)

---

## 🎊 After Getting Firestarter Role

### Immediate Benefits:
- �� **Access to Firestarter channels** in Discord
- 💬 **Community recognition** as verified operator
- 🎯 **Pathway unlocked** to higher roles (Testnet, OG)

### Next Steps:
1. **Engage in community** - help other new operators
2. **Share your experience** - create content about your journey
3. **Improve your node** - optimize performance and uptime
4. **Work toward Testnet role** - next level in progression

---

## 🏗️ Path to Higher Roles

### 🧪 Testnet Role (Next Level)
**Requirements:**
- ✅ Hold Firestarter role
- ✅ Run Testnet node with good performance  
- ✅ Active community participation
- ✅ Help other community members

**Benefits:**
- 🚀 Early access to new features
- 📊 Performance metrics access
- 🎁 Potential testnet rewards

### 👑 OG Role (Elite Status)  
**Requirements:**
- ✅ Hold Firestarter + Testnet + DevNet roles
- ✅ Joined Discord before March 31, 2025
- ✅ Significant community contributions

**Benefits:**
- 👑 Highest community status
- 🎯 Direct access to development team
- 💎 Exclusive rewards and opportunities
- 🏅 Permanent recognition as founding community member

---

## ❓ Verification FAQ

### "My links don't work"
- **Check the URLs** - make sure they're complete
- **Test in incognito mode** - avoid cache issues
- **Try different browser** - compatibility check
- **Recreate the links** - `pipe create-public-link [filename]`

### "Moderators haven't responded"
- **Be patient** - verification can take 24-48 hours
- **Don't spam** - one post is enough
- **Check your links** - make sure they work
- **Engage positively** - help others while waiting

### "I made a mistake in my post"
- **Edit if possible** - Discord allows editing recent posts
- **Post correction** - reply to your own post with corrections
- **Start fresh** - delete and repost if major errors

### "I don't have 3 different file types"
**Quick fix:**
```bash
# Create missing files
echo "Demo text for Discord" > text-demo.txt
echo "Confidential demo data" > secret-demo.txt

# Upload them
pipe upload-file text-demo.txt discord-text-demo
pipe upload-file secret-demo.txt discord-encrypted-demo --encrypt

# Create public links
pipe create-public-link discord-text-demo
pipe create-public-link discord-encrypted-demo
```

---

## 🎯 Success Tips

### For Faster Approval:
- ✅ **Test all links** before posting
- ✅ **Use the exact template** provided
- ✅ **Include all required information**
- ✅ **Be active in community** while waiting
- ✅ **Help other newcomers** with their setup

### Common Approval Delays:
- ❌ **Broken public links** - test before submitting
- ❌ **Missing information** - incomplete template
- ❌ **Wrong channel** - make sure you're in #firestarter-verification
- ❌ **Duplicate posts** - don't post multiple times

---

## 🏆 Community Contribution Ideas

**While waiting for role approval, contribute to the community:**

### Help Other Users
- Answer questions in Discord channels
- Share troubleshooting tips
- Guide newcomers through installation

### Create Content
- Write about your installation experience
- Share screenshots of successful operations
- Create video tutorials (optional)

### Technical Contributions
- Report bugs or issues
- Suggest improvements
- Share optimization tips

---

**🔥 Ready to get your Firestarter role? Follow the guide above! 🔥**
