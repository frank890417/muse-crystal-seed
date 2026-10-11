#!/usr/bin/env bash
# 晶種一鍵安裝
#
#   整顆晶種（新的 AI 夥伴 workspace，預設裝到 ~/my-agent）：
#     curl -fsSL https://raw.githubusercontent.com/frank890417/muse-crystal-seed/main/install.sh | bash
#     curl -fsSL https://raw.githubusercontent.com/frank890417/muse-crystal-seed/main/install.sh | bash -s -- ~/想放的資料夾
#
#   只裝技能到你已經有的資料夾（例如 Obsidian 知識庫）：
#     curl -fsSL https://raw.githubusercontent.com/frank890417/muse-crystal-seed/main/install.sh | bash -s -- --skills ~/你的知識庫
#
# 這支腳本不刪你的任何檔案：同名技能已經存在就跳過，不覆蓋。
set -euo pipefail

REPO="${CRYSTAL_SEED_REPO:-https://github.com/frank890417/muse-crystal-seed.git}"
MODE="seed"
TARGET=""

while [ $# -gt 0 ]; do
  case "$1" in
    --skills) MODE="skills"; shift; TARGET="${1:-}"; [ $# -gt 0 ] && shift ;;
    -h|--help) sed -n '2,11p' "$0" 2>/dev/null || true; exit 0 ;;
    *) TARGET="$1"; shift ;;
  esac
done

if ! command -v git >/dev/null 2>&1; then
  echo "✋ 找不到 git。Mac 請先在終端機打：xcode-select --install（裝好再跑一次）"
  exit 1
fi

if [ "$MODE" = "seed" ]; then
  TARGET="${TARGET:-$HOME/my-agent}"
  if [ -e "$TARGET" ]; then
    echo "✋ $TARGET 已經存在，為了不蓋掉你的東西我先停下來。"
    echo "   換一個資料夾：… | bash -s -- ~/別的名字"
    echo "   或只裝技能到這個資料夾：… | bash -s -- --skills $TARGET"
    exit 1
  fi
  git clone --depth 1 "$REPO" "$TARGET"
  echo
  echo "✅ 晶種裝好了：$TARGET"
  echo "   下一步："
  echo "     cd \"$TARGET\""
  echo "     claude"
  echo "   第一次醒來，它會帶你取名字、定個性。之後每次開工說「甦醒」或打 /become。"
  exit 0
fi

# --skills：只把技能複製進既有資料夾
if [ -z "$TARGET" ]; then
  echo "✋ 請告訴我要裝到哪個資料夾：… | bash -s -- --skills ~/你的知識庫"
  exit 1
fi
if [ ! -d "$TARGET" ]; then
  echo "✋ 找不到資料夾：$TARGET"
  exit 1
fi

TMP="$(mktemp -d "${TMPDIR:-/tmp}/crystal-seed.XXXXXX")"
trap 'rm -rf "$TMP"' EXIT
git clone --depth 1 --quiet "$REPO" "$TMP/seed"

mkdir -p "$TARGET/.claude/skills"
added=0; skipped=0
for dir in "$TMP/seed/.claude/skills"/*/; do
  name="$(basename "$dir")"
  if [ -e "$TARGET/.claude/skills/$name" ]; then
    echo "   ⏭  $name 已經有了，跳過（不覆蓋）"
    skipped=$((skipped + 1))
  else
    cp -R "$dir" "$TARGET/.claude/skills/$name"
    echo "   ＋ $name"
    added=$((added + 1))
  fi
done

# 寫日誌用的小工具：沒有才放
mkdir -p "$TARGET/tools"
if [ -f "$TMP/seed/tools/log.sh" ] && [ ! -e "$TARGET/tools/log.sh" ]; then
  cp "$TMP/seed/tools/log.sh" "$TARGET/tools/log.sh"
  chmod +x "$TARGET/tools/log.sh"
  echo "   ＋ tools/log.sh"
fi

echo
echo "✅ 裝了 $added 個技能、跳過 $skipped 個：$TARGET/.claude/skills"
echo "   重開 Claude Code，在對話框打 / 就看得到。"
echo "   第一次用的時候，它會問你知識庫在哪、待辦記在哪，答一次就記住。"
