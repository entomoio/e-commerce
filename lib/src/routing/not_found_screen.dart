import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/common_widgets/empty_placeholder_widget.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmptyPlaceholderWidget(
        message: context.loc.notFound404,
      ),
    );
  }
}
