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

## 2025-12-11

- feat(freezed): migrated most non-generated model and entity classes to `@freezed`
  - Converted DTOs, models and domain entities to `freezed` with `freezed_annotation` + `json_serializable` support.
  - Preserved compatibility helpers (`fromMap`, `fromSource`, `toJsonString`) where required.

- refactor(mason): updated `mason/feature_template` to generate `freezed`-based models/entities
  - Template files now emit `@freezed` models/DTOs/entities so newly scaffolded features follow the same patterns.

- build(codegen): ran `build_runner` and regenerated code across the repo
  - Multiple generator runs produced many `*.freezed.dart` and `*.g.dart` outputs; tests and mappers were adjusted to the new APIs.
  - Final analyzer run reported no issues.

- test: updated unit tests to match `freezed` conversions and compatibility factories
  - Adjusted tests to use updated `fromSource`/factory methods and fixed mapper expectations.

- infra(android): attempted Gradle migration for Flutter plugin
  - Added `pluginManagement` changes and exposed `flutterRoot` in `settings.gradle` to support declarative plugin application.
  - Investigated options to make `dev.flutter.flutter-gradle-plugin` resolvable (plugin repositories and included-build approaches).
  - Status: plugin artifact resolution remains the blocking item for producing a debug APK; further work (included-build pointing at the `.fvm` Flutter SDK plugin sources or alternative resolution) is recommended.
