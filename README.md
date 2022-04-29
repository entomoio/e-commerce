# localization_ecommerce

## App architecture 

This architecture is composed of four layers (data, domain, application, presentation). Comparison with Clean Archtecture.

![Riverpod Architecture](/assets/documentation/app_architecture.jpg?raw=true "Riverpod Architecture")
[ref: Flutter App Architecture with Riverpod: An Introduction](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)

## State Management

This project is using Riverpod (flutter_riverpod 2.0.0) to manage app state. Four provider types are mainly used:
-Provider
-FutureProvider
-StreamProvider
-StateNotifierProvider
[Flutter State Management with Riverpod: The Essential Guide](https://codewithandrea.com/articles/flutter-state-management-riverpod/)


## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
# e-commerce
