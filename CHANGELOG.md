# Changelog

## 2025-11-15

- Refactor: `ImageCaptionCubit.call` now returns the terminal `ImageCaptionState` instead of `void`. This avoids stream-subscription races and makes callers able to await the final result directly.
- Fix: `HomeCubit.uploadAndGenerateCaption` updated to use the new return value from `ImageCaptionCubit.call`, preventing a hang where the loading spinner could remain indefinitely.
- Tests: Added unit tests to cover synchronous terminal emission, failure, and unknown branches for `ImageCaptionCubit.call`.
- Harden: `LocalizationExtension.tr` returns an English fallback when `AppLocalizations.of(context)` is unavailable (helps widget tests without localization delegates).

### 2025-11-23

- feat(logging): improve TruncatingLogInterceptor JSON summaries

  - Summarizes Map/List responses and replaces large embedded values (e.g. base64 images) with compact descriptions (e.g. `Binary(180968 bytes)`) to keep logs readable.

- refactor(notification): make NotificationService.showSnackBar signature message-first

  - API now accepts `showSnackBar(String message, {BuildContext? context, ...})`.
  - Updated call sites and tests to the new signature so callers may omit `context`.

- fix(context): avoid using `BuildContext` across async gaps
  - Capture `AppLocalizations` early and use the global `NotificationService` fallback when showing snackbars after awaits. Updated several widgets/cubits accordingly.
