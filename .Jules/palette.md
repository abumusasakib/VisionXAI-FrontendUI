## 2024-03-24 - Interactive Images and Tactile Feedback
**Learning:** Found that long-press interactions on images (like the preview dialog) lack cursor affordances for non-touch platforms, making them hidden. Also, tapping `GestureDetector`s without `InkWell` feels dead.
**Action:** Always wrap long-press or tap-capable elements in `MouseRegion(cursor: SystemMouseCursors.zoomIn/click)` and use `InkWell` for visual ripple feedback.

## 2026-06-27 - InkWell placement in Stack
**Learning:** When using an `InkWell` inside a `Stack` to provide tactile feedback over an image, it must be placed *before* any interactive overlay elements (like markers) in the `children` list, otherwise it will intercept and block their touch events.
**Action:** Always ensure `InkWell` overlays used for image ripple effects are ordered beneath other interactive stack children.
