# Changelog

## [Unreleased] - 2025-11-15

- Refactor: `ImageCaptionCubit.call` now returns the terminal `ImageCaptionState` instead of `void`. This avoids stream-subscription races and makes callers able to await the final result directly.
- Fix: `HomeCubit.uploadAndGenerateCaption` updated to use the new return value from `ImageCaptionCubit.call`, preventing a hang where the loading spinner could remain indefinitely.
- Tests: Added unit tests to cover synchronous terminal emission, failure, and unknown branches for `ImageCaptionCubit.call`.
- Harden: `LocalizationExtension.tr` returns an English fallback when `AppLocalizations.of(context)` is unavailable (helps widget tests without localization delegates).
