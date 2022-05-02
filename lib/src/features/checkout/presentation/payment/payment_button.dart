import 'package:go_router/go_router.dart';
import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/common_widgets/primary_button.dart';
import 'package:localization_ecommerce/src/routing/app_router.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends StatelessWidget {
  const PaymentButton({Key? key}) : super(key: key);

  Future<void> _pay(BuildContext context) async {
    // TODO: Implement
    // showNotImplementedAlertDialog(context: context);
    context.goNamed(AppRoute.pdf.name);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: error handling
    // TODO: loading state
    return PrimaryButton(
      text: context.loc.receipt,
      isLoading: false,
      onPressed: () => _pay(context),
    );
  }
}
