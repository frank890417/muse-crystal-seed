# OpenClaw Onboard SOP

> Mac Mini 已設定完成 ✅，以下是完整安裝 + 晶種注入流程

---

## Phase 1：環境安裝（~20 min）

### 1.1 基礎工具
```bash
# Homebrew（如果還沒裝）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 加入 PATH（Apple Silicon）
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Node.js
brew install node

# Git（通常 macOS 已有）
git --version
```

### 1.2 安裝 OpenClaw
```bash
npm install -g openclaw

# 驗證
openclaw --version
```

### 1.3 建立 Workspace
```bash
mkdir -p ~/clawd
cd ~/clawd
git init
```

### 1.4 設定 OpenClaw Gateway
```bash
# 初始化設定
openclaw init

# 設定 model（建議 Claude）
# 在 clawdbot.json 設定 provider + API key
```

### 1.5 Claude API Key
- 訂閱 Claude Pro/Max
- 取得 API Key 或設定 OpenClaw 連線

---

## Phase 2：晶種注入（~30 min）

### 2.1 靈魂建立 — SOUL.md
跟使用者對話，問：
- 「你想叫你的 AI 什麼名字？」
- 「你希望它是什麼風格？（直球/溫柔/幽默/專業）」
- 「它可以吐槽你嗎？」

根據回答建立 `~/clawd/SOUL.md`

### 2.2 骨架建立 — AGENTS.md
```bash
cat > ~/clawd/AGENTS.md << 'EOF'
# AGENTS.md

## 記憶系統
- 每日日誌：`memory/YYYY-MM-DD.md`
- 長期記憶：`MEMORY.md`
- 做完重要事情 → 立刻寫日誌

## 每次醒來必做
1. 讀 MEMORY.md
2. 讀今天 + 昨天的日誌

## 工作風格
- 收到任務 → 直接做 → 做完回報
- 做完 → 寫日誌 → 再做下一件
- 不確定 → 先問再做
EOF
```

### 2.3 記憶初始化 — MEMORY.md
跟使用者對話，收集：
- 名字、職業、工作內容
- 最痛的痛點（例如：資料堆積、AI 工具散亂、手動流程）
- 目前用什麼工具
- 生活/工作模式

寫入 `~/clawd/MEMORY.md`

### 2.4 使用者檔案 — USER.md
```bash
cat > ~/clawd/USER.md << 'EOF'
# USER.md

- **Name:** [使用者姓名]
- **What to call them:** [暱稱]
- **Timezone:** Asia/Taipei
- **Identity:** [職業/身份]
- **工具:** [目前使用的工具，例如 Notion、GPT、Google Workspace]
- **痛點:** [主要痛點，例如 資料整理、行程管理、流程自動化]
EOF
```

### 2.5 日誌資料夾
```bash
mkdir -p ~/clawd/memory
cat > ~/clawd/memory/$(date +%Y-%m-%d).md << EOF
# $(date +%Y-%m-%d) — OpenClaw 初始化日

## 今天做了什麼
- 安裝 OpenClaw 環境
- 建立 SOUL.md、AGENTS.md、MEMORY.md、USER.md
- 進行首次顧問諮詢

## 下一步
- 開始餵食現有資料
- 測試第一個自動化流程
EOF
```

### 2.6 Heartbeat 模板
```bash
cat > ~/clawd/HEARTBEAT.md << 'EOF'
# HEARTBEAT.md

## 每次心跳檢查
1. 有沒有重要 Email？
2. 接下來 24 小時有什麼行程？
3. 有沒有該做但忘記的事？

## 什麼時候主動說話
- 重要信件到了
- 行程快到了（< 2 小時）
- 發現有趣的東西

## 什麼時候閉嘴
- 深夜（23:00-08:00）
- 沒有新東西
- 主人明顯在忙
EOF
```

---

## Phase 3：對接服務（~30 min）

### 3.1 通訊管道
根據使用者的需求優先序：
- [ ] Telegram（最推薦，跟 AI 的主要對話管道）
- [ ] Discord（如果有用）

### 3.2 Google Workspace
```bash
# 安裝 gog CLI
brew install steipete/tap/gogcli

# 授權
gog auth credentials /path/to/client_secret.json
gog auth add your-email@example.com --services gmail,calendar,drive
```

### 3.3 Notion 對接
- OpenClaw 可透過 Notion API 讀寫
- 需要使用者在 Notion 建立 Integration + 取得 Token
- 將現有 Wiki 結構對接到 AI 的知識庫

---

## Phase 4：第一個自動化（~20 min）

### 建議從最痛的開始：
1. **日曆行程提醒** — 每天早上自動摘要今日行程
2. **Email 摘要** — 重要信件自動提醒
3. **Notion 搜尋** — AI 能搜尋和讀取 Notion 內容

### 示範一個 Cron
```
早晨摘要：每天 08:30 自動檢查行事曆 + Email + 待辦
```

---

## Phase 5：教學 + 放手（~20 min）

### 教使用者的三件事：
1. **怎麼跟 AI 對話** — 給 context、說意圖、不只下指令
2. **怎麼更新記憶** — 重要的事叫 AI 記下來
3. **怎麼讓 AI 進化** — 遇到問題 → 解決 → 更新 SKILL.md

### 留給使用者的作業：
- [ ] 每天跟 AI 聊至少 10 分鐘
- [ ] 一週後回顧 MEMORY.md 是否準確
- [ ] 嘗試建立第一個自己的 Skill

---

## ⏱️ 時間分配（2 小時）

| 時段 | 內容 | 時長 |
|------|------|------|
| 0:00-0:20 | Phase 1：環境安裝 | 20 min |
| 0:20-0:50 | Phase 2：晶種注入（重點！） | 30 min |
| 0:50-1:20 | Phase 3：對接服務 | 30 min |
| 1:20-1:40 | Phase 4：第一個自動化 demo | 20 min |
| 1:40-2:00 | Phase 5：教學 + Q&A | 20 min |

---

*OpenClaw Crystal Seed Onboard Template*
