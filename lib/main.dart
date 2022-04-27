import 'dart:async';

import 'package:flutter/material.dart';

import 'src/app.dart';
// import 'src/settings/settings_controller.dart';
// import 'src/settings/settings_service.dart';
import 'package:localization_ecommerce/src/localization/string_hardcoded.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // * For more info on error handling, see:
  // * https://docs.flutter.dev/testing/errors
  await runZonedGuarded(() async {
    // Set up the SettingsController, which will glue user settings to multiple
    // Flutter Widgets.

    // final settingsController = SettingsController(SettingsService());

    // Load the user's preferred theme while the splash screen is displayed.
    // This prevents a sudden theme change when the app is first displayed.

    // await settingsController.loadSettings();

    // Run the app and pass in the SettingsController. The app listens to the
    // SettingsController for changes, then passes it further down to the
    // SettingsView.

    GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
    // runApp(MyApp(settingsController: settingsController));
    runApp(const MyApp());

    // * This code will present some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('An error occurred'.hardcoded),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }, (Object error, StackTrace stack) {
    // * Log any errors to console
    debugPrint(error.toString());
  });
}
