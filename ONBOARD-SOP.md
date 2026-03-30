# OpenClaw Onboard SOP

> 兩小時，裝好系統 + 注入靈魂。節奏要快，多線並行，但每一步都要讓使用者自己按按鈕。

---

## ⏱️ 時間分配（2 小時，嚴格執行）

| 時段 | 內容 | 時長 |
|------|------|------|
| 13:00-13:20 | Phase 1：環境安裝 | 20 min |
| 13:20-13:50 | Phase 2：晶種注入 + **AI 自訪談（核心！）** | 30 min |
| 13:50-14:20 | Phase 3：對接服務 | 30 min |
| 14:20-14:40 | Phase 4：第一個自動化 demo | 20 min |
| 14:40-14:50 | Phase 4.5：帶走包生成 | 10 min |
| 14:50-15:00 | Phase 5：Q&A + 放手 | 10 min |

> 💡 時段可依約定調整，但 2 小時總長度不要動。設計手機計時器，到時間就收尾。

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

> ⏳ **多線並行 Tip #1：** `npm install` 等待時 → 馬上切過去幫使用者設 Discord webhook。不要呆坐等。

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

# 設定 model（建議 Claude Sonnet 或 Opus）
# 在 clawdbot.json 設定 provider + API key
```

### 1.5 Claude API Key
- 建議使用 Claude Pro/Max 訂閱
- 取得 API Key → 貼進 clawdbot.json
- ⚠️ **安全教育（現場教）：** API key 就是密碼。不要截圖。不要傳給任何人。

---

## Phase 2：晶種注入（~30 min）

> 🔥 **這是整場最重要的 30 分鐘。** 不是填表格，是讓 AI 用對話方式認識主人。

### 2.1 AI 自訪談（殺手功能）

**不要叫使用者手動填 USER.md。讓 Agent 自己問。**

1. 先把 BOOTSTRAP.md 放進 workspace（`cp BOOTSTRAP.md ~/clawd/`）
2. 打開 OpenClaw 對話視窗
3. 讓使用者跟 AI 說：「嘿，我是 XX，我們來互相認識一下。」
4. AI 會開始問開放式問題，使用者用語音輸入回答

**語音輸入設定（如果使用者有 Whisper Flow 或類似工具）：**
```
系統偏好設定 → 麥克風授權 → Whisper Flow 啟動
```
> 語音比打字自然 10 倍。讓使用者把 20 分鐘人生故事說出來，AI 自動整理。

**顧問這時候做什麼：** 去準備 Phase 3 的 Google OAuth 設定（多線並行！）

### 2.2 訪談結束後，讓 AI 自動建檔

訪談結束後，跟 AI 說：
> 「把我們剛才聊的整理成 USER.md 和 MEMORY.md，寫進 ~/clawd/ 裡。」

### 2.3 靈魂建立 — SOUL.md

訪談過程中自然問出：
- 「你想叫你的 AI 什麼名字？」
- 「你希望它是什麼風格？（直球/溫柔/幽默/學者）」
- 「它可以吐槽你嗎？」
- 「你希望它什麼時候主動找你？」

讓 AI 根據對話自動產生 SOUL.md 草稿，使用者再微調。

### 2.4 骨架建立 — AGENTS.md

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

### 2.5 日誌資料夾

```bash
mkdir -p ~/clawd/memory
cat > ~/clawd/memory/$(date +%Y-%m-%d).md << EOF
# $(date +%Y-%m-%d) — OpenClaw 初始化日

## 今天做了什麼
- 安裝 OpenClaw 環境
- 完成 AI 自訪談，建立 SOUL.md / USER.md / MEMORY.md
- 進行首次系統設定

## 下一步
- 設定通訊管道（Discord/Telegram）
- 連接 Google Workspace
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

根據使用者需求優先選擇：
- [ ] **Discord**（推薦新手，設定簡單）
- [ ] **Telegram**（推薦主要對話管道，跨裝置同步）

> ⏳ **多線並行 Tip #2：** AI 跑訪談時 → 顧問同步設定 GitHub repo 備份。等 AI 建完檔，repo 也準備好了。

### 3.2 Google Workspace 設定（逐步 Checklist）

> ⚠️ 這個環節最容易卡。事先截圖每個步驟準備好。

**Step-by-step：**

- [ ] **Step 1：** 打開 [Google Cloud Console](https://console.cloud.google.com/)
- [ ] **Step 2：** 建新專案（Project Name 隨意，例如 `my-agent-2026`）
- [ ] **Step 3：** 左側選單 → APIs & Services → Enable APIs
  - 搜尋並啟用 **Gmail API**
  - 搜尋並啟用 **Google Calendar API**
  - （可選）搜尋並啟用 **Google Drive API**
- [ ] **Step 4：** OAuth consent screen → User Type: External → 填基本資訊（App name、Email）
- [ ] **Step 5：** Credentials → Create Credentials → OAuth client ID
  - Application type: **Desktop app**
  - 取個名字（例如 `openclaw-client`）
- [ ] **Step 6：** 下載 JSON 憑證檔（`client_secret_xxx.json`）
  - ⚠️ 這個檔案是密碼，不要傳給任何人、不要截圖
- [ ] **Step 7：** 在終端機執行授權

```bash
# 安裝 gog CLI
brew install steipete/tap/gogcli

# 授權（把剛剛下載的 JSON 路徑貼上）
gog auth credentials ~/Downloads/client_secret_xxx.json
gog auth add your-email@example.com --services gmail,calendar,drive
```

- [ ] **Step 8：** 驗證成功
```bash
gog gmail search "in:inbox" -a your-email@example.com
```

> ⏳ **多線並行 Tip #3：** OAuth 驗證等待瀏覽器跳轉時 → 趁機解釋系統架構給使用者聽。

### 3.3 GitHub 備份設定

```bash
cd ~/clawd
git add .
git commit -m "initial crystal seed"

# 在 GitHub 建立 private repo，然後：
git remote add origin https://github.com/[username]/[repo-name].git
git push -u origin main
```

> 💡 告訴使用者：「不管重裝系統或換電腦，你的 AI 知識都在 GitHub 這裡，永遠找得回來。」

---

## Phase 4：第一個自動化 demo（~20 min）

### 建議從最痛的開始：

1. **日曆行程提醒** — 每天早上自動摘要今日行程
2. **Email 摘要** — 重要信件自動提醒
3. **晨間 Briefing** — 起床第一件事，AI 主動說「今天有這些事」

### 示範一個 Cron

```
早晨摘要：每天 08:30 自動檢查行事曆 + Email + 待辦
```

讓使用者自己在 Discord/Telegram 收到第一個自動通知，看到那個「哇！」的反應。

---

## Phase 4.5：帶走包生成（~10 min）

> 🎯 **諮詢結束前 10 分鐘必做。** 讓使用者帶著明確的下一步離開，不是帶著滿腦霧水。

在 OpenClaw 輸入這個指令：
```
幫我產生一份 TAKEAWAY.md，記錄我們今天設定了什麼、我明天要做的第一件事、
這週的功課。格式參考 ~/clawd/TAKEAWAY.md 模板。
```

如果 repo 有 TAKEAWAY.md 模板，AI 會自動填入今天實際完成的項目。

讓使用者讀一遍，確認：
- ✅ 今天裝好了什麼
- 🎯 明天的第一個動作是什麼（越具體越好）
- 📋 這週的 3 件功課

---

## Phase 5：教學 + 放手（~10 min）

### 教使用者的三件事：

1. **怎麼跟 AI 對話** — 給 context、說意圖、不只下指令
2. **怎麼更新記憶** — 重要的事叫 AI 記下來（「記住我今天跟客戶談了XX」）
3. **怎麼讓 AI 進化** — 遇到問題 → 解決 → 更新 SOUL.md 或 MEMORY.md

### 話題發散時的收尾語：
> 「這個很棒，先記下來，我們先把核心搞定，之後再深入。」

---

## 安全教育 Checklist（現場教，不跳過）

- [ ] 搜尋結果第一個可能是釣魚廣告（示範如何辨識）
- [ ] API key = 密碼，不要截圖分享，不要傳 LINE/Messenger
- [ ] 權限最小化原則（需要什麼就開什麼，不要全開）
- [ ] GitHub repo 記得設 **Private**（除非你刻意要公開）
- [ ] client_secret JSON 不要放在容易被看到的地方

---

*OpenClaw Crystal Seed Onboard Template — 從實戰諮詢提煉*
