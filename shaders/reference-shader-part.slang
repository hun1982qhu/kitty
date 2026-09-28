#language slang 2026

// Kitty Custom Shader：The shader part 中文参考模板。
//
// 这不是普通的“键值配置文件”，而是一段 Slang GPU 程序。Kitty 会在自身
// 渲染结束后调用 fragment_main()，对当前像素执行后处理。
//
// 坐标约定：UV 原点位于左下角，x 向右、y 向上；颜色使用线性 RGB。
// 本模板原样返回输入颜色，所以即使被加载也不会改变画面。

import kitty_custom_shader_types;

// 可由 .pipeline 的 var 指令覆盖。只有 shader 中声明为 static const、且名称
// 与 pipeline 变量完全一致的值才能被覆盖。
static const float REFERENCE_GAIN = 1.0f;

// fragment_main() 的三个输入：
//
// color
//   本组前一个 shader 输出的颜色；若它是本组第一个 shader，则为 backbuffer
//   中当前像素的颜色。
//
// KittyTextures t（纹理与组状态，均由 Kitty 提供，只读）：
//   t.backbuffer              Kitty 已渲染的画面/上一组产生的新 backbuffer。
//   t.a                       pipeline 顶层 textures 声明的临时纹理 a。
//   t.b                       pipeline 顶层 textures 声明的临时纹理 b。
//   t.persist                 跨帧保留内容的持久纹理。
//   t.pos                     当前像素的 UV 坐标，范围 [0, 1]。
//   t.viewport                当前组的 (x, y, width, height) UV 区域。
//   t.animation_progress      经过 animation_curve 后的动画进度；未激活时为 0。
//   t.group                   当前组在 pipeline 中的索引。
//
// KittyTexture（t.backbuffer/t.a/t.b/t.persist 的字段与方法）：
//   .tex                      底层 Sampler2D；通常不要直接采样。
//   .scale                    当前 OS 窗口占底层纹理的比例。
//   .max_pos                  Sample() 可用的最大坐标，避免采到视口外像素。
//   .Sample(float2 pos)       推荐的采样方法；自动换算并把坐标限制在视口内。
//
// KittyCustomShaderData d（Kitty 运行时数据，均只读）：
//   d.src_rect                顶点 shader 内部使用的源矩形。
//   d.dest_rect               顶点 shader 内部使用的目标矩形。
//   d.background              kitty.conf 的全局背景色，线性 RGB，alpha=1。
//   d.foreground              kitty.conf 的全局前景色，线性 RGB，alpha=1。
//   d.active_window_background 当前标签页活动窗口的背景色。
//   d.mouse_pos.xy            当前鼠标 UV 坐标；超出 [0,1] 表示鼠标在窗口外。
//   d.mouse_pos.zw            最近一次鼠标左键按下时的 UV 坐标。
//   d.mouse_button_pressed    x/y/z/w 分别为左/右/中/button4 按下状态。
//   d.active_window_geometry  活动 Kitty 窗口的 (x, y, width, height) UV 区域。
//   d.active_window_padding   活动内容之外的 left/bottom/right/top 扩展范围。
//   d.bell_window_geometry    最近触发 BEL 的窗口区域；尚未触发时全为 0。
//   d.central_area            去除标签栏后的中央内容区域。
//   d.cursor_trail_corners_x  光标拖尾四个角的 x 坐标。
//   d.cursor_trail_corners_y  光标拖尾四个角的 y 坐标。
//   d.cursor_trail_edge       当前光标矩形的 left/right/top/bottom 边界。
//   d.cursor_trail_prev_edge  最近移动前光标矩形的四条边界。
//   d.cursor_color            活动窗口有效光标色 rgb 与透明度 a。
//   d.cursor_trail_color      有效拖尾色 rgb 与透明度 a。
//   d.viewport_size_pixels    底层完整视口的像素宽高。
//   d.mouse_pointer_hidden    鼠标隐藏为 1，显示为 0。
//   d.cursor_trail_state      光标拖尾正在动画为 1，否则为 0。
//   d.timestamp               Kitty 启动后的当前秒数，毫秒精度。
//   d.last_rendered_at        上一帧完成渲染时的秒数。
//   d.frame_counter           累计完整渲染帧数，第一帧为 0。
//   d.cursor_trail_change_time 最近一次触发拖尾的位置变化时间；初始为 0。
public float4
fragment_main(float4 color, KittyTextures t, KittyCustomShaderData d) {
    // REFERENCE_GAIN 默认是 1，因此这是透明传递效果。
    return color * REFERENCE_GAIN;
}
