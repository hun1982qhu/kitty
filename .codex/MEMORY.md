# Kitty 配置仓库记忆

供以后处理本仓库问题时快速了解背景。根目录 `AGENTS.md` 指定读取本文件；这是一项仓库约定，并非 Codex 自动识别的固定记忆文件路径。这里保存与仓库有关的**对话摘要**、用户决定和验证结果；它不是自动生成的逐字聊天存档。使用旧记录前，请重新检查当前配置、Kitty 版本和实际效果。

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

### 2026-10-25：补充 `.codex` 项目记忆入口

- 用户指出此前没有在当前路径的 `.codex` 中建立项目记忆文件。
- 已在仓库的 `.codex/` 下建立 `MEMORY.md` 符号链接，指向现有的 `../MEMORY.md`；历史记录保留，两个路径读取的是同一份内容。
- 当前受限工具环境会把 `.codex/` 显示为只读空目录；真实仓库中的链接已在非沙箱视图检查。后续仍可直接读取根目录的 `MEMORY.md`。
- 检查了当前 `kitty.conf` 的实际引用：`tode/keybinds.kitty.conf`、`Orwellian.conf` 和自定义 shader 设置；本次未改动 Kitty 配置，也未进行运行窗口视觉验证。

### 2026-10-25：讨论项目记忆存放位置

- 用户询问是否通常应将项目记忆放入仓库的 `.codex/`，以及根目录 `MEMORY.md` 是否为规范做法。
- 已核对：Codex 会识别 `AGENTS.md` 作为仓库指令；项目记忆文件的目录和文件名由项目约定，`MEMORY.md` 并非必须位于根目录。
- 更正同日先前记录：已把实际记忆文件移至 `.codex/MEMORY.md`，将根目录 `MEMORY.md` 改为指向它的符号链接，并更新 `AGENTS.md` 的读取和追加路径；历史记录保留，Kitty 配置未改动。

### 2026-10-29：讨论将主题配置移入子目录

- 用户询问将根目录主题 `.conf` 文件集中放到 `theme_config/`，并在 `kitty.conf` 写 `include theme_config/xxx.conf` 是否可行及如何操作。
- 现场确认 Kitty 0.49.2、主配置当前启用 `include Catppuccin-Mocha.conf`，主题文件仍在根目录，`theme_config/` 尚不存在；官方文档确认 `include` 相对路径以当前配置文件目录为基准。该对话仅说明写法，未移动主题文件或修改 Kitty 配置；原有未提交改动保留。
- 若决定实际整理，还需移动主题文件并同步更新启用的 `include` 路径，然后解析配置和在运行窗口重载确认效果。

### 2026-10-29：统一项目记忆文件入口

- 用户发现根目录 `MEMORY.md` 与 `.codex/MEMORY.md` 关联，询问标准放置方式，并授权按较简洁的做法整理。
- 现场确认根目录 `MEMORY.md` 是指向 `.codex/MEMORY.md` 的符号链接，后者是真实文件；`AGENTS.md` 已直接指定读取和追加 `.codex/MEMORY.md`。OpenAI 文档说明 `AGENTS.md` 是 Codex 识别的仓库指令文件，其他上下文文件由项目约定。
- 已移除根目录重复符号链接，保留 `.codex/MEMORY.md` 作为唯一项目记忆文件，并在文件开头说明入口约定。未改动 Kitty 配置，也未处理当前其他工作区改动；无待解决的记忆文件问题。

### 2026-10-29：确认后续对话记录范围

- 用户询问今后与助手的聊天记忆是否直接放入 `.codex/MEMORY.md`。
- 按当前 `AGENTS.md` 约定，今后与本 Kitty 仓库有关的对话结束时，在本文件追加简短摘要，不逐字保存聊天，也不记录无关项目或敏感内容。本次仅确认规则并追加记录，未改动 Kitty 配置；无待解决问题。
