# Aepyornis App

Mobile client for [Aepyornis](https://github.com/AepyornisNet/aepyornis).

## Prerequisites

- Flutter SDK (3.6.0 or newer)
- Dart SDK

## Code Generation Commands

This project uses several code generators for workout types, data models, and localizations.

### 1. Workout Types Generation
Generates workout type configurations from `workout-types.yaml`:
```bash
dart tool/generate_workout_types.dart
```

### 2. Data Models (`freezed` & `json_serializable`)
When creating or modifying `@freezed` or `@JsonSerializable` models in `lib/domain/models/`:
```bash
dart run build_runner build --delete-conflicting-outputs
```
*Or using Flutter:*
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Localization & Language Files (`l10n`)
When adding or updating translation keys in `.arb` files (`lib/l10n/app_en.arb`, `lib/l10n/app_de.arb`):
```bash
flutter gen-l10n
```

### 4. App Launcher Icons
To regenerate app icons from `assets/icon/app_icon.png`:
```bash
flutter pub run flutter_launcher_icons
```

## Development & Quality Checks

### Static Analysis
Run linting and type analysis:
```bash
flutter analyze
```

### Running Tests
Run all unit and widget tests:
```bash
flutter test
```

### Formatting Code
Format all Dart files according to standard code style:
```bash
dart format .
```
