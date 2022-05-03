import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization_ecommerce/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
// import '../lib/authentication/your_auth_using_firebase.dart';
import './mock.dart'; // from: https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/mock.dart

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });
  testWidgets('MyApp has a translated app title', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester
        .pumpWidget(const ProviderScope(child: MaterialApp(home: MyApp())));

    // Create the Finders.
    final titleFinder = find.text('My Shop');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
  });
}
