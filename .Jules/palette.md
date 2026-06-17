## 2024-03-24 - Interactive Images and Tactile Feedback
**Learning:** Found that long-press interactions on images (like the preview dialog) lack cursor affordances for non-touch platforms, making them hidden. Also, tapping `GestureDetector`s without `InkWell` feels dead.
**Action:** Always wrap long-press or tap-capable elements in `MouseRegion(cursor: SystemMouseCursors.zoomIn/click)` and use `InkWell` for visual ripple feedback.

## 2026-06-17 - Overlay Inkwell to preserve touch target precedence
**Learning:** When using an `InkWell` inside a `Stack` over an Image, placing the `InkWell` later in the `Stack` list might intercept touch events meant for interactive children (like markers).
**Action:** Ensure the `InkWell` (in a `Positioned.fill` + `Material`) is ordered *before* interactable marker widgets in the `Stack` list to properly share/propagate events.
