#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -gt 1 ]; then
  printf '用法：bash install.sh [机器人项目根目录]\n' >&2
  exit 1
fi

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
project_input="${1:-.}"

if [ ! -d "$project_input" ]; then
  printf '项目目录不存在：%s\n' "$project_input" >&2
  exit 1
fi
project_root="$(cd -- "$project_input" && pwd -P)"
skill_dir="$repo_dir/skills/robot-deployment"

case "$repo_dir" in
  "$project_root"/.codex|"$project_root"/.codex/*) ;;
  *)
    printf '请先将仓库克隆到机器人项目的 .codex 目录内，再从项目根目录运行本脚本。\n' >&2
    exit 1
    ;;
esac

if [ ! -f "$skill_dir/SKILL.md" ]; then
  printf '缺少技能文件：%s/SKILL.md\n' "$skill_dir" >&2
  exit 1
fi

for directory in "$project_root/.agents" "$project_root/.agents/skills"; do
  if [ -L "$directory" ] || { [ -e "$directory" ] && [ ! -d "$directory" ]; }; then
    printf '安装父路径不是普通目录，已停止以避免写入其他位置：%s\n' "$directory" >&2
    exit 1
  fi
done

target="$project_root/.agents/skills/robot-deployment"
if [ -L "$target" ] && [ -d "$target" ]; then
  resolved_target="$(cd -- "$target" && pwd -P)"
  if [ "$resolved_target" = "$skill_dir" ]; then
    printf '技能已安装，无需重复处理：%s\n' "$target"
    exit 0
  fi
fi

if [ -e "$target" ] || [ -L "$target" ]; then
  printf '目标位置已有其他内容，未做覆盖：%s\n' "$target" >&2
  exit 1
fi

# Relative links continue to work when the whole project moves.
repo_relative="${repo_dir#"$project_root"/}"
mkdir -p "$project_root/.agents/skills"
ln -s "../../$repo_relative/skills/robot-deployment" "$target"
printf '已安装技能：%s\n' "$target"
printf '在 Codex 中输入 $robot-deployment 即可使用。\n'
