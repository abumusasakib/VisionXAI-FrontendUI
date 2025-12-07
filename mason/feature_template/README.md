
# feature_template

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

This brick was created to be reusable across Flutter projects. The generated feature expects a few common dependencies in the consuming app — see "Dependencies" below.

## Quick usage

From a Flutter project (project root) with Mason installed:

```powershell
# Ensure bricks are available
mason get

# Generate a feature named `sample_feature` into an `example/` folder
mason make feature_template --name sample_feature --output-dir example
```

The brick will create a feature under `example/lib/features/sample_feature` (or under your chosen output path). The generated code is a starting point — you'll typically wire real endpoints and business logic after generation.

## Dependencies (add to your app `pubspec.yaml`)

The generated feature uses common packages. Add these to the consuming app so the generated code compiles and the analyzer is happy:

```yaml
dependencies:
  flutter:
    sdk: flutter
  equatable: ^2.0.3
  dartz: ^0.10.1
  flutter_bloc: ^8.1.3
  http: ^0.13.6
  dio: ^5.0.0
  retrofit: ^4.0.1
  json_annotation: ^4.9.0
  freezed_annotation: ^2.1.0

dev_dependencies:
  build_runner: ^2.4.6
  freezed: ^2.3.2
  retrofit_generator: ^4.0.1
```

Notes:

- `freezed` / `freezed_annotation` are only required if you keep the generated `EntityGroup` as a `freezed` union.

## Generate and analyze an example (recommended)

To see exactly what the brick emits and to run static analysis on the generated code, generate a sample feature into an `example/` folder and run the analyzer inside that folder:

```powershell
# generate a sample feature into ./example (from repo root)
mason make feature_template --name sample_feature --output-dir example

# move into the example folder and fetch packages
cd example; flutter pub get

# run the analyzer on the example package
flutter analyze .

# if the generated code uses `freezed`, run codegen
flutter pub run build_runner build --delete-conflicting-outputs
```
