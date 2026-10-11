#!/usr/bin/env bash
# 寫一段日誌到 memory/YYYY-MM-DD.md（只追加，不覆寫）
#
#   bash tools/log.sh '⟨官網線⟩ 首頁改版上線' <<'EOF'
#   - 📥 主人說：「首頁先上，作品頁下週」
#   ### 做了什麼
#   - 首頁換新版型，三張主圖重壓
#   ### 交付
#   - commit a1b2c3d、https://example.com
#   EOF
#
# 段標的時間由這支腳本在寫入那一刻用 date 取，不用自己打，就不會寫錯時間。
# 格式規範：.claude/skills/daily-log/SKILL.md
set -euo pipefail

TITLE="${1:-}"
case "$TITLE" in
  ⟨*⟩\ *) ;;
  *) echo "✋ 標題要長這樣：'⟨線名⟩ 動詞開頭的事件'（例：'⟨官網線⟩ 首頁改版上線'）" >&2; exit 1 ;;
esac

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DAY="$(date +%Y-%m-%d)"
NOW="$(date +%H:%M)"
LOG="$ROOT/memory/$DAY.md"
mkdir -p "$ROOT/memory"

BODY=""
if [ ! -t 0 ]; then BODY="$(cat)"; fi

if [ ! -e "$LOG" ]; then
  printf '# %s（%s）\n' "$DAY" "$(date +%A)" >> "$LOG"
fi

{
  printf '\n## %s %s\n' "$NOW" "$TITLE"
  if [ -n "$BODY" ]; then printf '%s\n' "$BODY"; fi
} >> "$LOG"

echo "📝 已寫入 memory/$DAY.md：## $NOW $TITLE"
