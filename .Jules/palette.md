## 2024-03-24 - Interactive Images and Tactile Feedback
**Learning:** Found that long-press interactions on images (like the preview dialog) lack cursor affordances for non-touch platforms, making them hidden. Also, tapping `GestureDetector`s without `InkWell` feels dead.
**Action:** Always wrap long-press or tap-capable elements in `MouseRegion(cursor: SystemMouseCursors.zoomIn/click)` and use `InkWell` for visual ripple feedback.
