import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:localization_ecommerce/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/features/checkout/presentation/payment/payment_page.dart';
import 'package:localization_ecommerce/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';

/// The two sub-routes that are presented as part of the checkout flow.
/// TODO: add the address page as well (see [AddressScreen]).
enum CheckoutSubRoute { register, payment }

/// This is the root widget of the checkout flow, which is composed of 2 pages:
/// 1. Register page
/// 2. Payment page
/// The correct page is displayed (and updated) based on whether the user is
/// signed in.
/// The logic for the entire flow is implemented in the
/// [CheckoutScreenController], while UI updates are handled by a
/// [PageController].
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _controller = PageController();

  var _subRoute = CheckoutSubRoute.register;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSignedIn() {
    setState(() => _subRoute = CheckoutSubRoute.payment);
    // perform a nice scroll animation to reveal the next page
    _controller.animateToPage(
      _subRoute.index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = ref.watch(authRepositoryProvider);
    final isLoggedIn = authRepository.currentUser != null;
    _subRoute =
        isLoggedIn ? CheckoutSubRoute.payment : CheckoutSubRoute.register;

    // map subRoute to address
    final title = _subRoute == CheckoutSubRoute.register
        ? context.loc.register
        : context.loc.payment;
    // * Return a Scaffold with a PageView containing the 2 pages.
    // * This allows for a nice scroll animation when switching between pages.
    // * Note: only the currently active page will be visible.
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PageView(
        // * disable swiping between pages
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          isLoggedIn
              ? const PaymentPage()
              : EmailPasswordSignInContents(
                  formType: EmailPasswordSignInFormType.register,
                  onSignedIn: _onSignedIn,
                ),
          !isLoggedIn
              ? EmailPasswordSignInContents(
                  formType: EmailPasswordSignInFormType.register,
                  onSignedIn: _onSignedIn,
                )
              : const PaymentPage(),
        ],
      ),
    );
  }
}
