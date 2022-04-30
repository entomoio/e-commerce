import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/features/authentication/domain/app_user.dart';
import 'package:localization_ecommerce/src/utils/in_memory_store.dart';

class FirebaseAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<AppUser?> authStateChanges() => _authState.stream;
  // Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  // Stream.value(null);

  // User? get currentUser => _firebaseAuth.currentUser;
  AppUser? get currentUser => _authState.value;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(
        email: email,
        password: password,
      ),
    );
    if (currentUser == null) {
      _createNewUser(email, userCredential.user?.uid);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (currentUser == null) {
      _createNewUser(email, userCredential.user?.uid);
    }
  }

  Future<void> signOut() async {
    // await Future.delayed(const Duration(seconds: 2));
    // throw Exception('Connection failed');
    await _firebaseAuth.signOut();
    _authState.value = null;
  }

  void dispose() => _authState.close();

  void _createNewUser(String email, String? uid) {
    _authState.value = AppUser(uid: uid ?? '', email: email);
  }
}

final authRepositoryProvider = Provider<FirebaseAuthRepository>((ref) {
  final auth = FirebaseAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangeProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
