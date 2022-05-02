import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/constants/breakpoints.dart';
import 'package:localization_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';
import 'package:localization_ecommerce/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/common_widgets/action_text_button.dart';
import 'package:localization_ecommerce/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:localization_ecommerce/src/features/products/presentation/home_app_bar/shopping_cart_icon.dart';
import 'package:go_router/go_router.dart';

/// Custom [AppBar] widget that is reused by the [ProductsListScreen] and
/// [ProductScreen].
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class HomeAppBar extends ConsumerWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangeProvider).value;
    // * This widget is responsive.
    // * On large screen sizes, it shows all the actions in the app bar.
    // * On small screen sizes, it shows only the shopping cart icon and a
    // * [MoreMenuButton].
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        title: InkWell(
          child: Text(context.loc.appBarTile),
          onTap: () {},
        ),
        actions: [
          const ShoppingCartIcon(),
          MoreMenuButton(user: user),
        ],
      );
    } else {
      return AppBar(
        title: InkWell(child: Text(context.loc.appBarTile), onTap: () => {}),
        actions: [
          const ShoppingCartIcon(),
          if (user != null) ...[
            // ActionTextButton(
            //   key: MoreMenuButton.ordersKey,
            //   text: 'Orders'.hardcoded,
            //   // onPressed: () => context.go('/orders'),
            //   onPressed: () => context.pushNamed(AppRoute.orders.name),
            // ),
            ActionTextButton(
              key: MoreMenuButton.accountKey,
              text: context.loc.account,
              onPressed: () => context.pushNamed(AppRoute.account.name),
              // onPressed: () => context.go('/account'),
            ),
          ] else
            ActionTextButton(
              key: MoreMenuButton.signInKey,
              text: context.loc.signin,
              onPressed: () => context.pushNamed(AppRoute.signIn.name),
              // onPressed: () => context.go('/signIn'),
            )
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
