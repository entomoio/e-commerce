import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization_ecommerce/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import './mock.dart'; // from: https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/mock.dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
    const MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  });
  // testWidgets('MyApp has a translated app title', (WidgetTester tester) async {
  //   // Create the widget by telling the tester to build it.
  //   await tester.pumpWidget(const ProviderScope(
  //       child: MaterialApp(
  //     // locale: Locale('en', 'US'),
  //     home: MyApp(),
  //   )));

  //   // Create the Finders.
  //   final titleFinder = find.text('Meu E-Commerce');

  //   // Use the `findsOneWidget` matcher provided by flutter_test to
  //   // verify that the Text widgets appear exactly once in the widget tree.
  //   expect(find.text('My Shop'), findsNothing);
  //   expect(titleFinder, findsOneWidget);
  // });
  testWidgets('MyApp has a translated app title', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const ProviderScope(
        child: MaterialApp(
      // locale: Locale('pt', 'BR'),
      locale: Locale('en', 'US'),
      home: MyApp(),
    )));

    // Create the Finders.
    final titleFinder = find.text('My Shop');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(find.text('Meu E-Commerce'), findsNothing);
  });
}
