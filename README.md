# localization_ecommerce

## App Architecture 

This architecture is composed of four layers (data, domain, application, presentation), in comparison with Clean Archtecture.

You can see more details on 
[Flutter App Architecture with Riverpod: An Introduction](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)


![Riverpod Architecture](/assets/documentation/app_architecture.jpg?raw=true "Riverpod Architecture")


## State Management

This project is using Riverpod (flutter_riverpod 2.0.0) to manage app state. 

To know the basics, please check
[Flutter State Management with Riverpod: The Essential Guide](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

Mainly, only four class types are being used:
- Provider
- FutureProvider
- StreamProvider
- StateNotifierProvider




## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
# e-commerce
