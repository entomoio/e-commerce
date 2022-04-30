import 'dart:math';

import 'package:localization_ecommerce/src/common_widgets/alert_dialogs.dart';
import 'package:localization_ecommerce/src/features/cart/domain/item.dart';
import 'package:localization_ecommerce/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/common_widgets/item_quantity_selector.dart';
import 'package:localization_ecommerce/src/common_widgets/primary_button.dart';
import 'package:localization_ecommerce/src/constants/app_sizes.dart';
import 'package:localization_ecommerce/src/features/products/domain/product.dart';
import 'package:localization_ecommerce/src/utils/in_persistent_store.dart';

/// A widget that shows an [ItemQuantitySelector] along with a [PrimaryButton]
/// to add the selected quantity of the item to the cart.
class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    const availableQuantity = 5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quantity:'.hardcoded),
            ItemQuantitySelector(
              // TODO: plug in state
              quantity: 1,
              // let the user choose up to the available quantity or
              // 10 items at most
              maxQuantity: min(availableQuantity, 10),
              // TODO: Implement onChanged
              onChanged: (value) {
                showNotImplementedAlertDialog(context: context);
              },
            ),
          ],
        ),
        gapH8,
        const Divider(),
        gapH8,
        PrimaryButton(
          // TODO: Loading state
          isLoading: false,
          // TODO: Implement onPressed
          onPressed: () {
            InPersistentStore().addCartItem(Item(
              productId: product.id,
              quantity: 1,
            ));
            // showNotImplementedAlertDialog(context: context);
          },
          text: availableQuantity > 0
              ? 'Add to Cart'.hardcoded
              : 'Out of Stock'.hardcoded,
        ),
        if (product.availableQuantity > 0 && availableQuantity == 0) ...[
          gapH8,
          Text(
            'Already added to cart'.hardcoded,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ]
      ],
    );
  }
}
