import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/common_widgets/alert_dialogs.dart';
import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isRefreshing && hasError) {
      showExceptionAlertDialog(
        context: context,
        title: context.loc.anErrorOccurred,
        exception: error,
      );
    }
  }
}
