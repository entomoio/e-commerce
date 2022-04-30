# localization_ecommerce

## App Architecture 

This architecture is composed of four layers (data, domain, application, presentation). The following image compares it with Clean Archtecture.

![Riverpod Architecture](/assets/documentation/app_architecture.jpg?raw=true "Riverpod Architecture")

More details on 
[Flutter App Architecture with Riverpod: An Introduction](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)



## State Management

This project is using Riverpod (flutter_riverpod 2.0.0), a reactive caching and data-binding framework. 

To know the basics, please check
[Flutter State Management with Riverpod: The Essential Guide](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

Mainly, only four class types are being used:
- Provider
- FutureProvider
- StreamProvider
- StateNotifierProvider


## Routing

Routes are implemented via GoRouter, a package maitained by Google. Navigator.Pop is still being used instead of GoRouter's contet.pop(), because it can return a value (e.g. when closing OK/Cancel alert dialog). Extensible documentation can be found in [GoRouter Docs](https://gorouter.dev/navigation)


## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)


## Notes

RxDart package is added just because of one method (BehaviorSubject.value), that can asynchronously show last emitted stream value, out of the box. Other implementations not always work correctly.

# e-commerce
