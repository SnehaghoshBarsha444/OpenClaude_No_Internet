# OpenClaude: Offline God-Mode Edition

A wrapper to run Claude Code locally using Ollama, optimized for low-RAM devices (4GB+) and flight mode.

## 🚀 Quick Start (Offline Mode)
1. **Install Ollama** (Windows/Linux/Termux).
2. **Pull the Model:** `ollama pull gemma4:e2b` (Recommended for 4GB RAM).
3. **Start Server:** Run `ollama serve`.
4. **Launch:** Run `claude` (via the provided launcher scripts).

---

## 📱 Termux One-Click Installation
The fastest way to get OpenClaude running on your Android device. Open Termux and paste this command:

```bash
pkg update -y && pkg upgrade -y && pkg install curl -y && curl -sL https://raw.githubusercontent.com/SnehaghoshBarsha444/OpenClaude_No_Internet/master/termux_setup.sh -o ~/termux_setup.sh && chmod +x ~/termux_setup.sh && bash ~/termux_setup.sh
```

### 🛠 Memory Optimizations for 4GB RAM
To prevent crashes on limited hardware, this version implements:
- **Context Limit:** `OLLAMA_NUM_CTX=2048` (Prevents RAM overflow).
- **Model:** Optimized for `gemma4:e2b` (Edge/Small version).
- **Backend:** Redirects API calls to `http://localhost:11434/v1`.

---

## 🔋 Mobile Hardware Control (Termux API)
OpenClaude comes with a toolkit to interact with your phone's hardware. These tools work on almost all Android devices without needing Root or Shizuku.

### 🛠 Installation for Hardware Tools:
To enable these features, you must:
1. Run: `pkg install termux-api`
2. Install the **Termux:API** app from F-Droid or Play Store.

### 🌟 Available Capabilities:
- **System Status:** Check battery percentage, WiFi state, and location.
- **Notifications:** Send high-priority system notifications.
- **Voice:** Use Text-to-Speech (TTS) to make the AI speak.
- **Communication:** Send SMS messages.
- **Hardware:** Control device vibration and take photos via camera.

---

## 🗑️ How to Uninstall

### From Termux:
To completely remove OpenClaude and its configuration, run the following commands in Termux:
```bash
# Remove the global package
npm uninstall -g @gitlawb/openclaude

# Remove the launcher and setup scripts
rm -f /data/data/com.termux/files/usr/bin/claude
rm -f ~/termux_setup.sh
rm -rf ~/scripts

# Optional: Remove Ollama if you no longer need it
pkg uninstall ollama
```

### From Windows:
If you used the `.bat` installer:
1. Delete the `openclaude_offline` folder.
2. Delete the `start_offline.bat` file.

---

## 🐧 Installation in Termux `proot-distro` (Linux)
To run this inside a Linux distro (like Ubuntu or Debian or Arch) for better compatibility:

1. **Install the Distro:**
   ```bash
   pkg install proot-distro
   proot-distro install ubuntu
   proot-distro login ubuntu
   ```
2. **Inside the Linux Shell, Install Node.js & Curl:**
   ```bash
   apt update && apt upgrade -y
   apt install curl git -y
   curl -fsSL https://deb.nodesource.com/setup_current.x | bash -
   apt install -y nodejs
   ```
3. **Install OpenClaude:**
   ```bash
   npm install -g @gitlawb/openclaude
   ```
4. **Running Ollama:**
   *Note: Ollama must usually run in the **main Termux environment** (outside proot) because it needs direct hardware access.*
   - Start `ollama serve` in the main Termux session.
   - Inside the `proot-distro` shell, point the URL to the Termux IP:
   ```bash
   export OPENAI_BASE_URL=http://127.0.0.1:11434/v1
   export CLAUDE_CODE_USE_OPENAI=1
   export OPENAI_API_KEY=ollama
   export OPENAI_MODEL=gemma4:e2b
   npx openclaude
   ```
