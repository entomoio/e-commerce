import 'package:go_router/go_router.dart';
import 'package:localization_ecommerce/src/features/cart/domain/item.dart';
import 'package:localization_ecommerce/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/common_widgets/primary_button.dart';
import 'package:localization_ecommerce/src/features/cart/presentation/shopping_cart/shopping_cart_item.dart';
import 'package:localization_ecommerce/src/features/cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'package:localization_ecommerce/src/routing/app_router.dart';
import 'package:localization_ecommerce/src/utils/in_persistent_store.dart';

/// Shopping cart screen showing the items in the cart (with editable
/// quantities) and a button to checkout.
class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // InPersistentStore().cartItemsList = '';
    final List<Item> cartItemsList = InPersistentStore().getCartList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'.hardcoded),
      ),
      body: ShoppingCartItemsBuilder(
        items: cartItemsList,
        itemBuilder: (_, item, index) => ShoppingCartItem(
          item: item,
          itemIndex: index,
        ),
        ctaBuilder: (_) => PrimaryButton(
          text: 'Checkout'.hardcoded,
          onPressed: () => context.pushNamed(AppRoute.checkout.name),
        ),
      ),
    );
  }
}
