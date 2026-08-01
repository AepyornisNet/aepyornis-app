---
name: flutter-tools
description: Provides commands and helper routines for Flutter and Dart workflows in this project (build, test, analyze, l10n, build_runner).
---

# Flutter & Dart Tools Skill

Use this skill when running Flutter/Dart commands, debugging build failures, running tests, or performing code generation in this repository.

## Environment Details
- **SDK Path**: `/home/brihm/develop/flutter/bin`
- **Flutter Executable**: `/home/brihm/develop/flutter/bin/flutter`
- **Dart Executable**: `/home/brihm/develop/flutter/bin/dart`

## Essential Workflows

### 1. Static Analysis
Run static analysis to check for lint errors and type mismatches:
```bash
/home/brihm/develop/flutter/bin/flutter analyze
```

### 2. Localization Generation (`l10n`)
If you see missing `package:flutter_gen/gen_l10n/app_localizations.dart` imports, generate them with:
```bash
/home/brihm/develop/flutter/bin/flutter gen-l10n
```

### 3. Code Generation (`build_runner`)
When creating or editing `@freezed` or `@JsonSerializable` classes in `lib/domain/models/`:
```bash
/home/brihm/develop/flutter/bin/dart run build_runner build --delete-conflicting-outputs
```

### 4. Running Tests
Run all unit and widget tests:
```bash
/home/brihm/develop/flutter/bin/flutter test
```
To run a specific test file:
```bash
/home/brihm/develop/flutter/bin/flutter test test/widget_test.dart
```

### 5. Formatting Code
Ensure standard formatting before finalizing changes:
```bash
/home/brihm/develop/flutter/bin/dart format .
```
