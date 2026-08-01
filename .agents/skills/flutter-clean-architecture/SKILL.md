---
name: flutter-clean-architecture
description: Architectural principles and layout rules for expanding features in this codebase (Domain, Data, UI, Routing, DI).
---

# Flutter Clean Architecture Skill

This project implements Clean Architecture with a feature-oriented UI structure.

## Core Layers & Dependency Direction

```
UI Layer  -->  Data Layer (Repositories)  -->  Domain Layer (Entities)
```

- **Domain Layer (`lib/domain/`)**: Independent of frameworks and third-party libraries. Contains business entities and contracts.
- **Data Layer (`lib/data/`)**: Implementations of repositories and services (HTTP REST API, SharedPreferences, Pedometer, GPS location).
- **UI Layer (`lib/ui/`)**: Feature components (`auth`, `home`, `recording`, `settings`, `statistic`, `workout`). Consumes data provided via Provider.
- **Config & DI (`lib/config/dependencies.dart`)**: Wire dependencies using `providersRemote`.

## Adding a New Feature Flow

1. **Domain Model**: Create entity model in `lib/domain/models/<feature>/<feature>.dart`.
2. **Repository Contract**: Define abstract interface class under `lib/data/repositories/<feature>/<feature>_repository.dart`.
3. **Repository Implementation**: Create remote implementation under `lib/data/repositories/<feature>/<feature>_repository_remote.dart`.
4. **Dependency Injection**: Add Provider binding into `providersRemote` in `lib/config/dependencies.dart`.
5. **UI & Routing**: Add screen widgets under `lib/ui/<feature>/` and register route in `lib/routing/router.dart`.
