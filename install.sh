#!/usr/bin/env bash
# github-oss-workflow + humanize-korean 함께 설치
# OpenCode 추천. Codex, Claude Code도 같이 설치 가능.
#
# 사용법:
#   bash install.sh            # 전부 (opencode, codex, claude)
#   bash install.sh opencode   # OpenCode만
#   bash install.sh codex
#   bash install.sh claude
set -euo pipefail

EDITOR_TARGET="${1:-all}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/skills"
HOME_DIR="${HOME:-$USERPROFILE}"

case "$EDITOR_TARGET" in
  all)      TARGETS=(opencode codex claude) ;;
  opencode) TARGETS=(opencode) ;;
  codex)    TARGETS=(codex) ;;
  claude)   TARGETS=(claude) ;;
  *) echo "사용법: $0 [all|opencode|codex|claude]" >&2; exit 1 ;;
esac

for target in "${TARGETS[@]}"; do
  case "$target" in
    opencode) dir="$HOME_DIR/.config/opencode/skills" ;;
    codex)    dir="$HOME_DIR/.codex/skills" ;;
    claude)   dir="$HOME_DIR/.claude/skills" ;;
  esac

  mkdir -p "$dir"
  echo "[$target] $dir"

  for skill in github-oss-workflow humanize-korean; do
    src_dir="$SRC/$skill"
    dst_dir="$dir/$skill"

    if [ ! -d "$src_dir" ]; then
      echo "없는 스킬 디렉터리: $src_dir" >&2
      exit 1
    fi

    if [ -e "$dst_dir" ]; then
      backup="$dst_dir.bak-$(date +%Y%m%d-%H%M%S)"
      mv "$dst_dir" "$backup"
      echo "  백업: $backup"
    fi

    cp -R "$src_dir" "$dst_dir"
    echo "  설치: $dst_dir"
  done
done

echo '끝. 에디터를 다시 시작하면 두 스킬이 같이 보입니다.'
