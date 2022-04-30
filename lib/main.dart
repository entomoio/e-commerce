import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
// import 'src/settings/settings_controller.dart';
// import 'src/settings/settings_service.dart';
import 'package:localization_ecommerce/src/localization/string_hardcoded.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  FirebaseApp defaultApp = await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAp7_vjyywMkKgEC9Od4LIe9fkU6NqN1Vc",
      appId: "1:96583856315:web:e56c413d5f5c98d77bf99e",
      messagingSenderId: "96583856315",
      projectId: "fi-base",
    ),
  );

  // * For more info on error handling, see:
  // * https://docs.flutter.dev/testing/errors
  //this will make appBar red and print the error on screen
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
    runApp(const ProviderScope(child: MyApp()));

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
