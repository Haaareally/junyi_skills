---
name: update-codex
description: 用于更新 Codex CLI 和共享后台服务，或排查升级后默认交互界面的 /model 菜单缺少目标模型。通过普通 codex 启动方式验证模型选择和当前会话状态。
---

# 更新 Codex CLI 并验收模型菜单

按用户要求决定执行范围。仅咨询或排查时先做只读检查。更新共享后台可能中断其他 Codex 会话，执行前告知影响，确认相关工作已保存或当前允许中断。如果当前会话也依赖该后台，将更新命令和验收步骤交给可独立使用的普通 shell 执行。

## 更新 CLI 和后台

1. 在用户平时启动 Codex 的 shell 中检查 `type -a codex` 和 `codex --version`。沿用该入口的安装方式，保留已有包装脚本、代理和安装前缀。具体路径、发布版本和目标模型以本次环境为准。
2. 运行 `codex update`。完成后重新执行 `codex --version` 核对默认入口。如果该版本没有更新命令，按实际安装渠道更新同一份 CLI，再查看新版帮助。
3. 对使用共享后台的环境，在后台所在主机执行 `codex app-server daemon version`，并从**更新后的 CLI** 运行 `codex app-server daemon update --help` 核对支持的选项。要让后台使用当前 CLI 包时，在可中断会话后执行以下命令。

   ```bash
   codex app-server daemon update --from-cli --yes
   codex app-server daemon version
   ```

   确认 `status` 为 `running`，核对 `cliVersion`、`managedCodexVersion` 和 `appServerVersion`（以当前版本实际返回的字段为准）。在跟随本次 CLI 包的配置下，三者应对应本次更新的版本。单独重启只会重新启动已安装的后台包。若新版仍缺少相应选项，按该版本帮助和官方说明选择支持的路径，记录未确认项。

4. `--from-cli` 将后台固定到本次选用的 CLI 包。以后升级 CLI 时也要更新后台。若要恢复官方发布渠道，按当前帮助使用不带 `--from-cli` 的 `codex app-server daemon update`，同样考虑服务重启的影响。

## 从用户实际使用的入口验收

保存工作并在旧交互界面输入 `/exit`。回到普通 shell，直接运行 `codex`，使用默认后台连接，不附加模型或诊断参数。进入新界面后：

1. 输入 `/model`，核对本次目标模型是否出现在可选列表中。按模型名称识别，菜单序号可能变化。
2. 选择用户需要的模型及推理强度（如提供），再输入 `/status` 核对当前会话的选择。若用户只要求检查可见性，汇报菜单结果即可。
3. 分别报告已观察到的版本、菜单和选中状态。只能执行非交互命令时，保留“默认菜单待验证”，并给出上述交互步骤。`codex exec -m …` 成功只验证指定模型调用，不能据此宣称默认菜单已通过验收。

## 菜单缺少目标模型时

- **先查启动入口。** 用 `type -a codex` 和 `codex --version` 检查 PATH、别名、包装脚本是否指向旧安装。Bash 的命令路径缓存可用 `hash -r` 刷新。
- **再查后台。** 核对 `codex app-server daemon version` 的运行版本。若共享后台落后，按上节更新，再开启新的默认会话。如果当前 CLI 支持 `codex --no-daemon`，可临时比较两个入口的 `/model`。差异有助于定位后台问题，修复后仍用普通 `codex` 复验。
- **最后查账号与目录。** 用 `codex login status` 核对登录状态，用 `codex debug models` 检查当前可见的模型目录，再结合账号、工作区权限和代理网络排查。`codex debug models --bundled` 只列程序自带的目录，不能证明账号权限或目标模型实际可用。

官方参考：[CLI 更新](https://learn.chatgpt.com/docs/codex/cli) · [命令与后台服务管理](https://learn.chatgpt.com/docs/developer-commands) · [模型选择](https://learn.chatgpt.com/docs/models?surface=cli)
