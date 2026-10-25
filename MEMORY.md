# Kitty 配置仓库记忆

供以后处理本仓库问题时快速了解背景。这里保存与仓库有关的**对话摘要**、用户决定和验证结果；它不是自动生成的逐字聊天存档。使用旧记录前，请重新检查当前配置、Kitty 版本和实际效果。

## 仓库概况

- 主配置：`kitty.conf`。主题文件位于仓库根目录；按键文件位于 `tode/`；自定义 shader 与参考资料位于 `shaders/`。
- 查找某项设置是否生效时，从 `kitty.conf` 的 `include`、`custom_shaders` 和键位定义出发，继续检查引用文件与 Kitty 的实际解析结果。存在于仓库中不代表已加载。
- 用户倾向于保留现有配置和未提交改动，只进行请求范围内的修改；在需要视觉验证时，应检查实际运行界面。

## 对话记录

### 2026-09-28：自定义 Shader 与 Bloom（此前对话摘要）

- 用户询问 `shaders/clear-bloom.pipeline` 和 `tode/keybinds.kitty.conf` 的作用、是否被引用，并讨论 Bloom 让粗体文字模糊的问题。
- 当时确认按键文件经 `kitty.conf` 引用，其中 `Ctrl+Shift+C` 映射为 `copy_or_noop`。Bloom pipeline 是否生效取决于 `custom_shaders` 的当前值，需每次重查。
- 当时的 Kitty 版本为 0.49.1。Bloom 作用于渲染后的整张画面，配置中可调 `BLOOM_THRESHOLD`、`BLOOM_STRENGTH`，没有仅针对粗体的参数。
- 曾建立 `shaders/reference-shader-part.slang`、`shaders/reference-pipeline-part.pipeline` 和 `shaders/reference-animation-events.pipeline` 作为参考资料；这些参考文件当时未启用。
- 以上是历史结论。当前版本、数值和引用关系可能已经变化。

### 2026-10-25：建立仓库记忆

- 用户要求在当前 Kitty 配置仓库中建立专用记忆文件，持续积累我们关于该仓库的聊天记录，帮助未来理解配置。
- 新建本文件，并用 `AGENTS.md` 提醒后续在处理仓库问题时阅读、追加对话摘要和核对现状。
- 建立时现场检查：Kitty 为 0.49.2；`kitty.conf` 引用 `tode/keybinds.kitty.conf`，主题行为 `include Orwellian`，`custom_shaders` 行为 `clear-bloom cursor-trail-blaze dim-inactive-windows pond-ripple`。这些仅表示配置文本，不等于已完成运行界面验证。
- 建立前工作区已有未提交的 `kitty.conf` 修改和未跟踪的 `Adapta Nokto Maia.conf`；本次未改动它们。

### 2026-10-25：`include Orwellian` 未使主题生效

- 用户报告在 `kitty.conf` 添加 `include Orwellian` 并保存后，主题没有明显变化，询问原因。
- 用 Kitty 0.49.2 的配置解析器检查，得到 `Could not find included config file: /home/huangning/.config/kitty/Orwellian, ignoring`。`include` 按给出的文件名查找，不自动补 `.conf`；实际文件名是 `Orwellian.conf`。
- 已将该行改为 `include Orwellian.conf`。再次解析无错误，读出的前景色为 `#f1f1f1`、背景色为 `#2e2923`、`color1` 为 `#e74946`，与主题文件一致；`git diff --check` 通过。尚未在用户当前 Kitty 窗口做视觉验证。
- 当前配置有 `kitty_mod ctrl+shift` 和 `map kitty_mod+f5 load_config_file`；可按 `Ctrl+Shift+F5` 手动重载配置。
