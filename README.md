# robot_deployment

可直接克隆使用的 Codex skill。规则包括中文沟通和报告、英文 Git commit 和代码注释、直白有条理的表达，以及将复查文档集中到项目的 `review/`、临时文件集中到 `tmp/`、一次性结果不保存。

## 使用

在机器人项目根目录执行：

```bash
git clone https://github.com/Haaareally/robot_deployment.git .agents/skills/robot-deployment
```

无需安装脚本、目录链接或额外配置。在该项目中开始新的 Codex 会话，然后输入：

```text
$robot-deployment 按照这个技能的规则处理当前机器人部署项目。
```

技能也允许在相关任务中自动选择；显式调用可以明确要求本次任务使用这些规则。仓库和显示名称为 `robot_deployment`，技能标识按规范使用 `robot-deployment`。

本仓库根目录就是技能目录，完整规则见 [SKILL.md](SKILL.md)。`review/` 和 `tmp/` 属于机器人项目，不放在本技能目录中。

## 更新

在机器人项目根目录执行：

```bash
git -C .agents/skills/robot-deployment pull --ff-only
```

更新后开始新的 Codex 会话。修改规则只需编辑 `SKILL.md`，检查差异后用英文提交。

如果曾使用旧版安装脚本，请先移除它创建的 `.agents/skills/robot-deployment` 链接，再执行上面的克隆命令；只有确认目标是旧链接时才移除，不删除已有技能目录。

项目技能目录依据 [Codex 技能文档](https://developers.openai.com/codex/skills/)。
