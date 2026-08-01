# Antigravity Agent Rules for aepyornis-app

## Project Overview
`aepyornis-app` is a Flutter mobile application for tracking workouts and fitness activities, acting as a client for the Aepyornis backend (`AepyornisNet/aepyornis`).

---

## SDK & Tooling Environment
> [!IMPORTANT]
> Flutter and Dart SDKs are installed at `/home/brihm/develop/flutter/bin`.
> Always use the full path or export PATH before running CLI commands.

- **Flutter Binary**: `/home/brihm/develop/flutter/bin/flutter`
- **Dart Binary**: `/home/brihm/develop/flutter/bin/dart`

### Standard Commands

```bash
# Export PATH for session
export PATH="/home/brihm/develop/flutter/bin:$PATH"

# Run static analysis
/home/brihm/develop/flutter/bin/flutter analyze

# Run unit and widget tests
/home/brihm/develop/flutter/bin/flutter test

# Run code generation (Freezed / JSON Serializable)
/home/brihm/develop/flutter/bin/dart run build_runner build --delete-conflicting-outputs

# Format code
/home/brihm/develop/flutter/bin/dart format .

# Check dependencies / upgrade
/home/brihm/develop/flutter/bin/flutter pub get
```

---

## Architectural Guidelines

This project follows **Clean Architecture** principles structured into four main layers:

```
lib/
├── config/        # Dependency injection (Provider declarations)
├── domain/        # Entities, domain models, and core contracts
│   └── models/    # Freezed data models (e.g. workout, user, measurement)
├── data/          # Data layer implementation
│   ├── repositories/  # Repository implementations (remote & local)
│   └── services/      # Low-level services (ApiClient, SharedPreferences)
├── routing/       # GoRouter configuration & routes
├── ui/            # UI components and view models grouped by feature
│   ├── auth/
│   ├── home/
│   ├── recording/
│   ├── settings/
│   ├── statistic/
│   ├── workout/
│   └── core/      # Reusable widgets and themes
└── l10n/          # Localization files (.arb)
```

### Layer Rules & Responsibilities

1. **Domain Layer (`lib/domain/`)**:
   - Contains immutable data models generated with `@freezed` and `@JsonSerializable`.
   - Free from UI or framework dependencies (pure Dart).
   - Always run `build_runner` when adding or modifying `@freezed` models.

2. **Data Layer (`lib/data/`)**:
   - `services/`: Handles HTTP requests (`ApiClient`), local storage (`SharedPreferencesService`), pedometer, and location tracking.
   - `repositories/`: Encapsulates data sources behind abstract contracts (e.g. `AuthRepository`, `WorkoutRepository`).

3. **UI Layer (`lib/ui/`)**:
   - Components consume repositories and view models via `Provider`.
   - Never perform direct network calls or database ops from UI widgets.
   - Design follows Material 3 with support for Light and Dark themes (`AppTheme`).

4. **Dependency Injection (`lib/config/dependencies.dart`)**:
   - Uses `MultiProvider` for injecting `ApiClient`, `SharedPreferencesService`, and repository instances (`providersRemote`).

5. **Localization (`lib/l10n/`)**:
   - Strings are defined in `.arb` files and accessed via `AppLocalizations.of(context)`.
   - **Always add translations**: Whenever adding or editing user-facing UI strings, always add localized keys in all `.arb` files (`app_en.arb`, `app_de.arb`). Never hardcode user-visible UI strings in widgets.
   - Always run `/home/brihm/develop/flutter/bin/flutter gen-l10n` whenever `.arb` files are updated.

---

## Code Quality & Conventions

- Maintain strict Dart typing and null safety.
- Follow Flutter lints (`analysis_options.yaml`).
- Always add complete translations (English and German) for any new or modified user-facing UI text.
- Always run `/home/brihm/develop/flutter/bin/flutter test` and `/home/brihm/develop/flutter/bin/flutter analyze` before committing changes.
