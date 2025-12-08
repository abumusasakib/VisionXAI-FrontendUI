# VisionXAI

A Flutter application with dynamic localization, BLoC state management, Hive for persistence, and routing.

---

## Key Components of this Project

### 1. **Localization Support**

- Localization with `flutter_localizations`.
- ARB files are located in `lib/l10n`.
- Code generation uses `flutter_gen_runner`.

### 2. **State Management**

- Using `flutter_bloc` and `bloc` for managing application state.

### 3. **Persistence**

- Using `hive` and `hive_flutter` for lightweight storage.

### 4. **Dynamic Routing**

- `go_router` for navigation and dynamic route handling.

### 5. **Utilities**

- `intl`: For formatting dates and numbers based on locale.

### 6. **Code Generation Tools**

- `build_runner`: For code generation.
- `flutter_gen_runner`: Automatically generate localization code.

### 7. **Cross-Platform Compatibility**

- **Android**, **Windows**, and **Web** apps can be built and run seamlessly.
- The app is designed to be functional on **mobile**, **desktop**, and **web** platforms.

---

## Run the Pre-configured Project in Docker

Ensure you have Docker installed and running in your system and you are inside the `vision_xai` directory of the project. It is recommended that a stable and high-speed internet is there while using Docker to configure the project. You may need to run Docker as superuser if on Linux.

### Automating build using Node.js

You need to have Node.js installed before using the setup build scripts.

#### How It Works

- **Platform-Specific Check**: The shell and batch scripts handle the initial check for Node.js.
- **Installation Prompt**: If Node.js isn't installed, the script provides a link and exits.
- **Running the Node.js Script**: Once Node.js is confirmed to be installed, the script proceeds to execute `setup.js`, which will handle the rest of the setup.

#### Usage Instructions

1. **macOS/Linux**: Run `chmod +x setup.sh` to make the shell script executable, then execute it with `./setup.sh`.
2. **Windows**: Double-click the `setup.bat` file, or run it in Command Prompt. To run the setup script on Powershell, use `./setup.bat`.

### Running the Docker Compose

1. **Build and Run the Docker Container**:

   ```bash
   docker-compose up --build
   ```

   OR

   ```bash
   docker compose up --build
   ```

   This command will build the Docker image, run the container, build the APK, and copy the release apk to the `./build` directory on your local machine, as well as run a web server to serve the web version of the app.

   This would take a very long time; so please be patient. All processes will be finished as soon as it accepts connections for the Flutter web app.
2. **Access the Flutter Web App:**

   After the build completes and the web server starts, you can access the Flutter web app by opening your web browser and navigating to:

   ```text
   http://localhost:5000
   ```

   To exit, press Ctrl+C twice.

---

## Directory Structure for VisionXAI

Below is the detailed directory structure for the **VisionXAI** Flutter project. This structure organizes the app into logical modules, ensuring modularity and clarity in code maintenance.

```plaintext
VisionXAI-FrontendUI/
├── example/
│   └── lib/features/sample_feature/
│       └── [Standard Feature Pattern] (data, domain, core, presentation)
│
├── lib/
│   ├── features/
│   │   ├── image_caption/
│   │   │   ├── data/
│   │   │   │   ├── model/ (*.dart + generated *.freezed.dart, *.g.dart)
│   │   │   │   ├── datasource/remote/
│   │   │   │   ├── mapper/ (json→model→entity mappers)
│   │   │   │   └── repository/*_repo_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entity/ (*.dart + generated files)
│   │   │   │   ├── repository/*_repo.dart
│   │   │   │   └── use_case/*_uc.dart
│   │   │   ├── core/
│   │   │   │   ├── di/*_injection.dart
│   │   │   │   ├── export/*_export.dart
│   │   │   │   └── utils/
│   │   │   └── presentation/
│   │   │       ├── cubit/ (state management)
│   │   │       └── screen/ (UI + widgets/)
│   │   │
│   │   ├── settings/
│   │   │   ├── about/ [Standard Pattern]
│   │   │   └── [Standard Pattern] (data, domain)
│   │   │
│   │   └── color_palette/
│   │       ├── core/ (di, managers, workers, utils)
│   │       ├── data/ (datasource, repository)
│   │       └── presentation/ (cubit, screens)
│   │
│   ├── core/
│   │   ├── common/ (tts_client.dart)
│   │   ├── widgets/ (custom widgets)
│   │   ├── constants/ (ip_details, string_res)
│   │   ├── di/ (app_di, service_locator)
│   │   ├── network/ (interceptors)
│   │   └── routes/ (app_routes, routes)
│   │
│   ├── gen/assets.gen.dart
│   ├── l10n/ (localization files: *.arb, generated *.dart)
│   └── main.dart
│
├── config/
│   ├── .fvmrc, .gitignore, analysis_options.yaml
│   ├── pubspec.yaml, pubspec.lock
│   ├── l10n.yaml, l10n_errors.txt
│   ├── flutter_launcher_icons.yaml
│   ├── flutter_native_splash.yaml
│   ├── docker-compose.yml, Dockerfile*
│   └── devtools_options.yaml
│
├── mason/ (code generation templates)
│   ├── feature_template/ (__brick__, brick.yaml, hooks/)
│   └── mason-lock.json
│
├── setup scripts/ (setup.sh, setup.bat, setup.js)
│
├── assets/
│   ├── about.png, splash.png
│   └── icon/icon.png
│
├── test/
│   ├── core/services/ (error_handler, notification tests)
│   └── features/ [Mirror lib/features structure]
│       ├── image_caption/ (mapper, model, repository, cubit tests)
│       └── settings/ (similar test patterns)
│
├── android/
│   ├── app/ (build.gradle, src/[debug|main|profile]/AndroidManifest.xml)
│   ├── gradle/ (wrapper, properties)
│   └── build.gradle, settings.gradle
│
├── web/
│   ├── index.html, manifest.json, favicon.png
│   ├── icons/ (various sizes: 192, 512, maskable)
│   └── splash/img/ (dark/light variants: 1x-4x)
│
├── windows/
│   ├── CMakeLists.txt
│   ├── flutter/ (generated plugins, registrant)
│   └── runner/ (main, resources, window management)
│
└── docs/
    ├── CHANGELOG.md
    └── README.md
```

## Pattern Summary

**Standard Feature Pattern** (repeated across features):

```plaintext
feature_name/
├── data/ (models, datasources, mappers, repository_impl)
├── domain/ (entities, repository interface, use_cases)
├── core/ (di, exports, utils)
└── presentation/ (cubits, screens, widgets)
```

**Generated Files Pattern**:

- `*.freezed.dart` (immutable models)
- `*.g.dart` (JSON serialization)

**Localization Pattern**:

- `app_*.arb` (source)
- `app_localizations_*.dart` (generated)

---

### **Key Directories**

- **`lib/`**: Contains all the application logic, widgets, and business logic.
- **`android/`**: Contains Android-specific configurations and resources.
- **`web/`**: Contains web-specific resources, including `index.html`.
- **`windows/`**: Contains Windows-specific build configurations and app runner files.
- **`assets/`**: Holds images and other static resources.
- **`test/`**: Includes unit and widget tests for validating app functionality.

This directory structure ensures clarity, modularity, and scalability, making it easier for developers to navigate and maintain the **VisionXAI** project.

---

## Setup Instructions

### Install Dependencies

Run the following command to install all project dependencies:

```bash
fvm flutter pub get
```

---

### Generate Localization Files

To generate the Dart localization code from the ARB files, run:

```bash
fvm flutter pub run build_runner build
```

This will generate the `app_localizations.dart` file in the `lib/l10n` directory.

---

## Building and Running the Application

### **Android**

1. Ensure you have the Android SDK installed and configured.
2. Run the following command to build the APK in release mode:

   ```bash
   fvm flutter build apk --release
   ```

3. The generated APK will be located in the `build/app/outputs/flutter-apk/` directory.
4. To build an **AAB** (Android App Bundle) for uploading to the Play Store, use:

   ```bash
   fvm flutter build appbundle --release
   ```

---

### **Windows**

1. Ensure you have the Windows desktop development environment set up, and the `flutter_windows` plugin enabled.
2. Run the following command to build the Windows executable in release mode:

   ```bash
   fvm flutter build windows --release
   ```

3. The executable will be located in the `build/windows/runner/Release/` directory.

To **run** the app on Windows, use:

```bash
fvm flutter run -d windows
```

---

### **Web**

1. **Serve the Application**:
   To serve the app locally for testing, run:

   ```bash
   fvm flutter run -d chrome
   ```

   This will start the app in a web browser on your local machine.

2. **Build for Release**:
   To build the app for deployment on the web, use:

   ```bash
   fvm flutter build web --release
   ```

   The built files will be located in the `build/web/` directory. These files can be deployed to any web server.

---

## Additional Notes

1. **State Management with BLoC**:
   - The app uses **BLoC (Business Logic Component)** for state management in the project. This helps in keeping the UI layer separate from the business logic.
   - Each feature (like Home or Settings) has its own `Cubit` and `State` file to handle specific functionality, making the code modular and easier to maintain.

2. **Localization**:
   - The `l10n/` folder is dedicated to managing the app's language and translations. Each supported language should have an ARB file for storing translated strings.
   - `flutter_localizations` is used to dynamically switch languages based on user preference, and the `flutter_gen_runner` tool is used to generate the Dart localization files automatically.

3. **Persistence (Hive)**:
   - The app uses **Hive** for storing user preferences like IP and port configuration in a lightweight and efficient manner. This is managed inside the `settings/` folder where the user's preferences are saved and loaded.

4. **Routing with `go_router`**:
   - The app uses the **`go_router`** package for navigation and route management. This package is ideal for handling nested routes and providing a declarative approach to routing.
