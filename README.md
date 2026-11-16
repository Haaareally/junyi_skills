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
└── robot-deployment/
    ├── SKILL.md
    └── agents/
        └── openai.yaml
```

当前包含：

- [read-and-explain](read-and-explain/SKILL.md)：用中文讲解论文、架构和算法，结合核心代码与必要的数学原理。显示名称为 `read_and_explain`，通过 `$read-and-explain` 调用。
- [robot-deployment](robot-deployment/SKILL.md)：机器人部署项目的中文沟通、文件管理、模型任务匹配、严重风险警告、安全终止与完整任务程序交付规则。

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

阅读论文或代码时，可以这样调用：

```text
$read-and-explain 帮我读懂这篇论文，按输入到输出的顺序讲清架构，并结合仓库中的核心代码和必要公式解释。
```

Codex 会先了解各技能的名称、简介和位置，选中某个技能后再读取其完整规则；不会因为放在同一仓库就把所有技能正文一并加载。简介应简短，并明确适用任务。详见 [官方技能说明](https://learn.chatgpt.com/docs/build-skills)。

## 更新与新增技能

在项目根目录更新：

```bash
git -C .agents/skills pull --ff-only
```

如果使用子目录方式，将命令中的路径改为 `.agents/skills/junyi_skills`。更新后开始新的 Codex 会话。

新增技能时，在本仓库根目录创建独立文件夹，并写入带有 `name` 和 `description` 的 `SKILL.md`。文件夹和技能名称保持一致，使用小写字母、数字和连字符。需要时再增加 `agents/openai.yaml`、参考资料或脚本，不创建空占位目录。

技能修改使用英文 Git commit 信息。任务中的 `review/` 和 `tmp/` 属于正在操作的项目，不放在本技能集合中。

如果已经克隆过旧版 `robot_deployment`，先保存本地改动，再按上述集合结构迁移；迁移后保留一份有效的 `robot-deployment` 技能，避免重复发现。不要覆盖已有目录或直接删除尚未保存的文件。
