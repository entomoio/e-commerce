import 'package:localization_ecommerce/src/features/cart/domain/item.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/features/checkout/presentation/payment/payment_button.dart';
import 'package:localization_ecommerce/src/features/cart/presentation/shopping_cart/shopping_cart_item.dart';
import 'package:localization_ecommerce/src/features/cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'package:localization_ecommerce/src/utils/in_persistent_store.dart';

/// Payment screen showing the items in the cart (with read-only quantities) and
/// a button to checkout.
class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Listen to cart changes on checkout and update the UI.
    // TODO: Read from data source
    final List<Item> cartItemsList = InPersistentStore().getCartList();

    return ShoppingCartItemsBuilder(
      items: cartItemsList,
      itemBuilder: (_, item, index) => ShoppingCartItem(
        item: item,
        itemIndex: index,
        isEditable: false,
      ),
      ctaBuilder: (_) => const PaymentButton(),
    );
  }
}
