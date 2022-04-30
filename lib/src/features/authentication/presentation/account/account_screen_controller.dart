import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue.data(null));
  final FirebaseAuthRepository authRepository;

  Future<void> signOut() async {
    //set state to loading
    //sign out (using auth repository)
    //if success, set state to data
    //if fail, set state to error

    // try {
    //   state = const AsyncValue<void>.loading();
    //   await authRepository.signOut();
    //   state = const AsyncValue<void>.data(null);
    //   return true;
    // } catch (e) {
    //   state = AsyncValue<void>.error(e);
    //   return false;
    // }

    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepository.signOut());

    //goRouter refreshListenable redirects logout
    // return !state.hasError;
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
