import 'package:go_router/go_router.dart';
import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/common_widgets/primary_button.dart';
import 'package:localization_ecommerce/src/routing/app_router.dart';
import 'package:localization_ecommerce/src/utils/in_persistent_store.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends StatelessWidget {
  const PaymentButton({Key? key}) : super(key: key);

  Future<void> _pay(BuildContext context) async {
    // TODO: Implement
    // showNotImplementedAlertDialog(context: context);
    InPersistentStore().cartItemsList = '';
    context.goNamed(AppRoute.home.name);
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
