# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter e-commerce application built with a 4-layer architecture (data, domain, application, presentation) inspired by Clean Architecture. The app demonstrates best practices for Flutter development including state management with Riverpod, routing with GoRouter, Firebase authentication, localization, and PDF generation.

## Core Technologies

- **Flutter SDK**: 2.17.0+ (Flutter 3.0)
- **State Management**: Riverpod 2.0.0 (flutter_riverpod)
- **Routing**: GoRouter 3.0.3
- **Authentication**: Firebase Auth
- **Localization**: flutter_gen with ARB files (English and Portuguese)
- **PDF Generation**: pdf package for invoice generation

## Development Commands

### Running the App
```bash
flutter run                    # Run on connected device/emulator
flutter run -d chrome --web-renderer html  # Run on web with HTML renderer
flutter run -d chrome --web-renderer canvaskit  # Run on web with CanvasKit renderer
```

### Testing
```bash
flutter test                                    # Run all tests
flutter test test/path/to/test_file.dart       # Run specific test file
flutter test --coverage                         # Run tests with coverage
```

### Building
```bash
flutter build web              # Build for web
flutter build apk              # Build Android APK
flutter build ios              # Build for iOS (requires macOS)
```

### Code Quality
```bash
flutter analyze                # Run static analysis
flutter pub get                # Install dependencies
flutter clean                  # Clean build artifacts
```

### Localization
```bash
flutter gen-l10n               # Generate localization files from ARB files
```

Localization files are in `lib/src/localization/` (app_en.arb, app_pt.arb). The generation is configured in `l10n.yaml` and happens automatically during build, but can be run manually if needed.

## Architecture

### 4-Layer Structure

Each feature follows this organization:

```
lib/src/features/{feature_name}/
├── data/           # Repositories and data sources
├── domain/         # Entity models and business logic
├── application/    # (optional) Application services
└── presentation/   # UI widgets and controllers
```

**Key Principles:**
- **Data Layer**: Repositories that fetch/store data (e.g., FakeProductsRepository, FirebaseAuthRepository)
- **Domain Layer**: Pure Dart entity classes with no Flutter dependencies
- **Presentation Layer**: Widgets and StateNotifier controllers for UI logic
- Riverpod providers connect these layers

### State Management with Riverpod

The app uses four main provider types:
- **Provider**: For immutable dependencies (repositories, services)
- **FutureProvider**: For async data fetching
- **StreamProvider**: For realtime data streams
- **StateNotifierProvider**: For mutable state with controllers

Example pattern:
```dart
// Repository provider
final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

// Stream provider consuming repository
final productsListStreamProvider = StreamProvider<List<Product>>((ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.watchProductsList();
});
```

### Routing with GoRouter

Routes are centrally defined in `lib/src/routing/app_router.dart` using the `AppRoute` enum. The router includes:
- Route guards for authenticated-only pages (orders, account)
- Nested routes (e.g., product/:id/review)
- Full-screen dialogs for cart, checkout, orders, account
- Auto-redirect on auth state changes

Use `context.goNamed(AppRoute.product.name, params: {'id': productId})` for navigation.

**Important**: While GoRouter is used for navigation, `Navigator.pop()` is used instead of `context.pop()` when a return value is needed (e.g., OK/Cancel dialogs).

## Key Features

### Features Structure
- **authentication**: Firebase auth with sign in/sign up, fake auth repository for testing
- **products**: Product listings, search, product details, ratings
- **cart**: Shopping cart with add/remove items
- **checkout**: Checkout flow with payment
- **orders**: Order history and details
- **reviews**: Leave and view product reviews
- **pdf**: Generate invoice PDFs
- **address**: User address management

### Common Patterns

**AsyncValue Handling**: Use `AsyncValueWidget` from `lib/src/common_widgets/async_value_widget.dart` to handle loading, error, and data states consistently.

**Error Display**: Use `ErrorMessageWidget` for consistent error messages.

**Responsive Layout**: Use `ResponsiveTwoColumnLayout` and `ResponsiveCenter` from common_widgets for responsive UIs.

**Localization**: Access localized strings via `context.loc` (extension on BuildContext) - see `lib/src/localization/app_localizations_context.dart`. For hardcoded strings during development, use `.hardcoded` extension.

## Firebase Configuration

Firebase is initialized in `main.dart` with web credentials. The app uses Firebase Authentication for user management. To use with other platforms, add platform-specific Firebase configuration files.

## Testing

Tests are located in `test/` mirroring the `lib/` structure. Use `flutter_test` for unit and widget tests. Mock dependencies are defined in `test/src/mock.dart`.

To test a single file during development:
```bash
flutter test test/src/features/authentication/presentation/sign_in/string_validators_test.dart
```

## Important Notes

- **RxDart**: Used minimally, primarily for `BehaviorSubject.value` to get the last emitted stream value synchronously
- **Persistence**: Uses `InPersistentStore` (wrapper around SharedPreferences) for local data persistence
- **Error Handling**: Configured in `main.dart` with `runZonedGuarded` to display errors in a red AppBar with error details
- **URL Strategy**: Uses path-based URLs (not hash) via `GoRouter.setUrlPathStrategy(UrlPathStrategy.path)`

## Code Style

- Follow the lints in `analysis_options.yaml` (package:flutter_lints)
- Use `flutter analyze` before committing
- Repository pattern: All data access goes through repository classes
- Keep domain models pure (no Flutter/UI dependencies)
- Use Riverpod providers for dependency injection
