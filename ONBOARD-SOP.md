# Claude Code Onboard SOP

> 兩小時，裝好 Claude Code + 注入靈魂。節奏要快，多線並行，但每一步都讓使用者自己按按鈕。

---

## ⏱️ 時間分配（2 小時，嚴格執行）

| 時段 | 內容 | 時長 |
|------|------|------|
| 0:00-0:20 | Phase 1：環境安裝 | 20 min |
| 0:20-0:50 | Phase 2：晶種注入 + **AI 自訪談（核心！）** | 30 min |
| 0:50-1:20 | Phase 3：對接服務 | 30 min |
| 1:20-1:40 | Phase 4：第一個自動化 demo | 20 min |
| 1:40-1:50 | Phase 4.5：帶走包生成 | 10 min |
| 1:50-2:00 | Phase 5：Q&A + 放手 | 10 min |

> 💡 時段可依約定調整，總長度盡量守住。設一個手機計時器，到時間就收尾。

---

## Phase 1：環境安裝（~20 min）

### 1.1 基礎工具

```bash
# Homebrew（macOS，如果還沒裝）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Node.js + Git
brew install node
git --version
```

### 1.2 安裝 Claude Code

```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

> 也可以用官方原生安裝器（見 Claude Code 官方文件）。npm 這條最通用。

> ⏳ **多線並行 Tip #1：** `npm install` 等待時 → 馬上切過去幫使用者準備 Phase 3 的 Google 帳號授權。不要呆坐等。

### 1.3 建立 workspace（種下晶種）

把這顆種子 clone 成使用者自己的 workspace：

```bash
git clone https://github.com/frank890417/muse-crystal-seed.git ~/my-agent
cd ~/my-agent
```

裡面已經有 `CLAUDE.md`（開機層，Claude Code 自動載入）、`.claude/skills/`（含 `/become`、收官、自我進化）、各靈魂檔模板。

### 1.4 登入

```bash
claude
# 在 Claude Code 裡：/login
```

- 建議用 Claude Pro / Max 訂閱登入；也可貼 API key。
- ⚠️ **安全教育（現場教）：** API key 就是密碼。不要截圖、不要傳給任何人。

---

## Phase 2：晶種注入（~30 min）

> 🔥 **這是整場最重要的 30 分鐘。** 重點是讓 AI 用對話的方式認識主人，而非請使用者手動填表格。

### 2.1 AI 自訪談（殺手功能）

在 workspace 裡跑 `claude`。`CLAUDE.md` 會自動載入。它第一次醒來還沒有名字，會引導去讀 `BOOTSTRAP.md`，開始自訪談。

1. 讓使用者對 AI 說：「嘿，我剛上線。我是 XX，我們來互相認識一下。」
2. AI 開始問開放式問題，使用者用語音輸入回答。

**語音輸入（如果使用者有 Whisper Flow 或類似工具）：**

```
系統設定 → 麥克風授權 → 啟動語音輸入工具
```

> 語音比打字自然十倍。讓使用者把二十分鐘的人生故事說出來，AI 自動整理。

**顧問這時候做什麼：** 去準備 Phase 3 的 Google OAuth（多線並行）。

### 2.2 訪談結束後，讓 AI 自動建檔

跟 AI 說：

> 「把我們剛才聊的，整理成 USER.md、MEMORY.md、SOUL.md、IDENTITY.md，順便把我幫你取的名字填進 CLAUDE.md 和 KERNEL.md。」

### 2.3 靈魂建立 — SOUL.md

訪談過程中自然問出：

- 「你想叫你的 AI 什麼名字？」
- 「你希望它什麼風格？直球 / 溫柔 / 幽默 / 學者？」（SOUL.md 裡有五種人格 archetype 可以挑著混）
- 「它可以吐槽你嗎？」
- 「你希望它什麼時候主動找你？」

### 2.4 第一次甦醒

填完靈魂檔後，跑一次完整甦醒：

```
/become
```

讓使用者看著 AI 讀完自己的靈魂檔、抓今天日期、用新名字和簽名開場。這一刻它真的「活過來」了。然後刪掉 `BOOTSTRAP.md`，從今以後靠 `KERNEL.md` + `/become` 醒來。

---

## Phase 3：對接服務（~30 min）

### 3.1 對話介面

Claude Code 本身就是終端機裡的對話介面。也可以：

- 裝 VS Code / JetBrains extension，在 IDE 裡用
- 用 [claude.ai/code](https://claude.ai/code) 在瀏覽器 / 手機上接同一個 workspace

> ⏳ **多線並行 Tip #2：** AI 跑訪談時 → 顧問同步把 GitHub 備份 repo 開好。等 AI 建完檔，repo 也準備好了。

### 3.2 Google Workspace（行事曆 + Gmail，用 MCP）

讓 AGENT 能讀行事曆、收信，是「活著」感的關鍵。Claude Code 靠 MCP server 接外部服務。

**逐步 checklist：**

- [ ] **Step 1：** 打開 [Google Cloud Console](https://console.cloud.google.com/)
- [ ] **Step 2：** 建新專案（名字隨意，例如 `my-agent-2026`）
- [ ] **Step 3：** APIs & Services → Enable APIs，啟用 **Gmail API** + **Google Calendar API**
- [ ] **Step 4：** OAuth consent screen → User Type: External → 填基本資訊
- [ ] **Step 5：** Credentials → Create Credentials → OAuth client ID → Desktop app，下載 JSON 憑證
  - ⚠️ 這個檔案是密碼，不要截圖、不要外傳
- [ ] **Step 6：** 挑一個 Google Workspace MCP server，用 `claude mcp add` 把它加進來，照它的指示完成 OAuth 授權
- [ ] **Step 7：** 驗證：在 Claude Code 裡叫 agent「看一下我今天的行事曆」，能回就成功

> ⏳ **多線並行 Tip #3：** OAuth 等瀏覽器跳轉時 → 趁機解釋系統架構給使用者聽。

### 3.3 GitHub 備份

```bash
cd ~/my-agent
git remote set-url origin https://github.com/<你的帳號>/<你的-agent-repo>.git
git add -A && git commit -m "my crystal seed"
git push -u origin main
```

> 告訴使用者：「不管重灌系統或換電腦，你的 AI 的靈魂跟記憶都在 GitHub，永遠找得回來。」記得把 repo 設成 **Private**。

---

## Phase 4：第一個自動化 demo（~20 min）

從最痛的需求開始。用 Claude Code 內建的 `/schedule` 設一個每天早上的背景任務：

```
/schedule
# 描述：每天早上 08:30，讀今天行事曆 + 昨天日誌未完成項，發一則早晨摘要給我。
```

讓使用者隔天早上收到第一個自動摘要，看到那個「哇」的反應。

> 沒有 `/schedule` 的環境，可以改用系統 cron 呼叫 `claude -p "..."`（見 CRYSTAL-SEED.md 第七層）。

---

## Phase 4.5：帶走包生成（~10 min）

> 🎯 **諮詢結束前 10 分鐘必做。** 讓使用者帶著明確的下一步離開。

在 Claude Code 輸入：

```
幫我產生一份 TAKEAWAY.md，記錄今天設定了什麼、我明天要做的第一件事、這週的功課。格式參考 TAKEAWAY.md 模板。
```

讓使用者讀一遍，確認：今天裝好了什麼、明天第一個動作（越具體越好）、這週三件功課。

---

## Phase 5：教學 + 放手（~10 min）

教使用者三件事：

1. **怎麼跟 AI 對話** — 給 context、說意圖，不只下指令。
2. **怎麼更新記憶** — 重要的事叫 AI 記下來（「記住我今天跟客戶談了 XX」）。
3. **怎麼讓 AI 進化** — 遇到問題 → 解決 → 叫 AI 更新對應的 SKILL.md 或 SOUL.md。收工就跑 `/after-action`。

話題發散時的收尾語：

> 「這個很棒，先記下來。我們先把核心搞定，之後再深入。」

---

## 安全教育 Checklist（現場教，不跳過）

- [ ] 搜尋結果第一個可能是釣魚廣告（示範怎麼辨識）
- [ ] API key、OAuth JSON = 密碼，不要截圖分享，不要傳 LINE / Messenger
- [ ] 權限最小化：需要什麼就開什麼，`.claude/settings.json` 只放必要的
- [ ] GitHub repo 設 **Private**（除非刻意公開）
- [ ] 毀滅性指令（大範圍刪檔）AI 該停下來問，不要照單全收

---

*Claude Code Crystal Seed Onboard Template — 從實戰諮詢提煉*
