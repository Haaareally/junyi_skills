# junyi_skills

Junyi 的 Codex 技能集合。每个技能放在独立目录中，可以分别维护和调用，无需安装脚本或额外配置。

## 目录结构

```text
junyi_skills/
├── README.md
├── .gitignore
├── read-and-explain/
│   ├── SKILL.md
│   └── agents/
│       └── openai.yaml
├── robot-deployment/
│   ├── SKILL.md
│   └── agents/
│       └── openai.yaml
└── survey-and-discuss/
    ├── SKILL.md
    └── agents/
        └── openai.yaml
```

当前包含：

- [read-and-explain](read-and-explain/SKILL.md)：用中文讲解论文、架构和算法，结合核心代码与必要的数学原理。显示名称为 `read_and_explain`，通过 `$read-and-explain` 调用。
- [robot-deployment](robot-deployment/SKILL.md)：机器人部署项目的中文进度说明、`LOG.md` 日志、文件管理、模型任务匹配、严重风险警告、安全终止与完整任务程序交付规则。
- [survey-and-discuss](survey-and-discuss/SKILL.md)：目标明确时聚焦检索，开放构思时跨方向探索；审核证据后逐项讲清具体方法、核心机制与改进，最后简述实验效果，再横向比较并独立讨论。

## 使用

在要操作的项目根目录执行：

```bash
git clone https://github.com/Haaareally/junyi_skills.git .agents/skills
```

Git 会自动创建目录。如果项目已经有 `.agents/skills/`，将本集合克隆到它下面，保留其他技能：

```bash
git clone https://github.com/Haaareally/junyi_skills.git .agents/skills/junyi_skills
```

这两种位置都已验证能被 Codex 识别。在该项目中开始新会话，通过技能名调用：

```text
$robot-deployment 按照这个技能的规则处理当前机器人部署项目。
```

也可以在已安装技能的机器人项目根目录，从终端发起 README 更新。

```bash
codex '$robot-deployment 根据当前项目的真实入口更新 README，用终端演示怎么启动服务、调整常用参数、确认就绪、调用主要功能和停止服务。'
```

阅读论文或代码时，可以这样调用：

```text
$read-and-explain 帮我读懂这篇论文，按输入到输出的顺序讲清架构，并结合仓库中的核心代码和必要公式解释。
```

调研方向或探讨想法时，可以这样调用：

```text
$survey-and-discuss 我想探索这个方向，请适度跨领域检索，逐项讲清重点工作要做什么、具体怎么做、为什么这样设计、改进了什么，最后简述效果，再讨论下一步值得验证什么。
```

Codex 会先了解各技能的名称、简介和位置，选中某个技能后再读取其完整规则；不会因为放在同一仓库就把所有技能正文一并加载。简介应简短，并明确适用任务。详见 [官方技能说明](https://learn.chatgpt.com/docs/build-skills)。

## 用终端预览部署规则

在本技能仓库根目录打开终端 1，用 Python 3 启动文档预览服务并保持运行。

```bash
python3 -m http.server 8765 --bind 127.0.0.1 --directory robot-deployment
```

`8765` 是端口（默认 `8000`），`--bind 127.0.0.1` 只接受本机连接，`--directory robot-deployment` 指定要展示的目录。端口已占用时可换一个空闲端口，并同步修改下面的网址。

在终端 2 读取规则文件并查看技能名。

```bash
curl -fsS http://127.0.0.1:8765/SKILL.md | sed -n '1,2p'
```

```text
---
name: robot-deployment
```

看到技能名表示预览服务已能提供文件。回到终端 1 按 `Ctrl+C` 停止服务。

## 更新与新增技能

在项目根目录更新：

```bash
git -C .agents/skills pull --ff-only
```

如果使用子目录方式，将命令中的路径改为 `.agents/skills/junyi_skills`。更新后开始新的 Codex 会话。

新增技能时，在本仓库根目录创建独立文件夹，并写入带有 `name` 和 `description` 的 `SKILL.md`。文件夹和技能名称保持一致，使用小写字母、数字和连字符。需要时再增加 `agents/openai.yaml`、参考资料或脚本，不创建空占位目录。

技能修改使用英文 Git commit 信息。机器人部署任务的重要日志按时间追加到工作目录的 `LOG.md`，简明记录进度和当前问题；必要图片与数据可嵌入或链接，重要独立附件集中到项目的 `review/assets/`。复查材料只保留与重要决策、关键验证、问题定位或最终交付有关的内容，不加入零散调试输出、重复截图和无关中间结果。这些日志、`review/` 和 `tmp/` 都属于正在操作的项目，不放在本技能集合中。

临时功能测试脚本默认放项目的 `tmp/`，用户指定或工具需要时也可使用系统 `/tmp/`，不混入主要代码目录。需要长期维护的重要测试或评测代码放项目的正式测试目录；重要结果按 `LOG.md` 和 `review/` 规则保留。

如果已经克隆过旧版 `robot_deployment`，先保存本地改动，再按上述集合结构迁移；迁移后保留一份有效的 `robot-deployment` 技能，避免重复发现。不要覆盖已有目录或直接删除尚未保存的文件。
