# robot_deployment

机器人部署项目使用的 Codex skill。当前只约定三件事：中文沟通和报告、直白有条理的表达、统一存放复查文件和临时文件。Git commit 信息与代码注释使用英文。

仓库名称和显示名称为 `robot_deployment`。技能名称按命名规范使用 `robot-deployment`，在 Codex 中通过 `$robot-deployment` 调用。

## 安装到项目

需要 Git 和 Bash；适用于 macOS、Linux 和 WSL。在机器人项目根目录执行：

```bash
git clone https://github.com/Haaareally/robot_deployment.git .codex
bash .codex/install.sh
```

如果项目已经有 `.codex/`，保留原目录，改用：

```bash
git clone https://github.com/Haaareally/robot_deployment.git .codex/robot_deployment
bash .codex/robot_deployment/install.sh
```

安装脚本只创建一个目录链接：`.agents/skills/robot-deployment`，指向仓库中的 `skills/robot-deployment/`。这个链接让 Codex 找到实际存放在 `.codex/` 下的技能。重复运行可安全跳过已安装的相同链接；若同名位置已有其他内容，或者 `.agents`、`.agents/skills` 已经是链接，脚本会停止并提示，不覆盖文件或写入其他位置。

安装时默认把当前目录作为机器人项目根目录，也可显式指定：

```bash
bash /path/to/project/.codex/install.sh /path/to/project
```

在该项目中打开 Codex，输入：

```text
$robot-deployment 按照这个技能的规则，帮我处理当前机器人部署项目。
```

技能允许 Codex 在相关任务中自动选择；显式调用可确保本次任务使用这些规则。若技能列表尚未刷新，重新打开 Codex 后再试。

## 文件约定

| 内容 | 位置或处理方式 |
| --- | --- |
| 长期保留、供人复查的管理文件 | 机器人项目的 `review/`，或项目已经约定的统一目录 |
| 检查过程中暂时需要的文件 | 机器人项目的 `tmp/`，不提交到 Git |
| 用完不会再用的复查结果或日志 | 直接展示，不额外保存；工具必须落盘时，用后删除本次临时文件 |

这些路径都属于机器人项目，不能放进本技能仓库。完整规则见 [SKILL.md](skills/robot-deployment/SKILL.md)。

## Git 管理

本仓库独立维护，只跟踪技能、安装脚本和使用说明。根目录采用允许列表，避免将克隆位置下新生成的本地配置或运行记录意外加入仓库。

更新技能时，在机器人项目根目录执行：

```bash
git -C .codex pull --ff-only
```

如果采用已有 `.codex/` 的安装方式，将上面的 `.codex` 替换为 `.codex/robot_deployment`。目录链接不需要重建。

修改规则时编辑 `skills/robot-deployment/SKILL.md`，在本仓库中检查差异并用英文提交。不要将整个机器人项目或个人配置提交到本仓库。外层项目若不需要跟踪这些本地安装文件，可将 `.codex/` 和 `.agents/skills/robot-deployment` 加入外层项目自己的 `.gitignore`。

安装方式依据 [Codex 技能文档](https://developers.openai.com/codex/skills/)；技能名称依据 [Agent Skills 命名规范](https://agentskills.io/specification#name-field)。
