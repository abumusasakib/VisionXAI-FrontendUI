## 2024-03-24 - Interactive Images and Tactile Feedback
**Learning:** Found that long-press interactions on images (like the preview dialog) lack cursor affordances for non-touch platforms, making them hidden. Also, tapping `GestureDetector`s without `InkWell` feels dead.
**Action:** Always wrap long-press or tap-capable elements in `MouseRegion(cursor: SystemMouseCursors.zoomIn/click)` and use `InkWell` for visual ripple feedback.

## 2026-06-21 - Tactile Feedback for Image Previews
**Learning:** Found that `GestureDetector` interactions on images lack visual tactile feedback and keyboard focusability. While `MouseRegion` provides cursor affordances, tapping feels dead.
**Action:** Replaced `GestureDetector` and `MouseRegion` with an `InkWell` layered over the image using a `Stack` and transparent `Material` to provide a responsive ripple effect, keyboard focusability, and built-in cursor styling.
