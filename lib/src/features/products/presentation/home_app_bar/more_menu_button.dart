import 'package:firebase_auth/firebase_auth.dart';
import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';
import 'package:localization_ecommerce/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PopupMenuOption {
  signIn,
  orders,
  account,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({Key? key, this.user}) : super(key: key);
  final User? user;

  // * Keys for testing using find.byKey()
  static const signInKey = Key('menuSignIn');
  static const ordersKey = Key('menuOrders');
  static const accountKey = Key('menuAccount');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // three vertical dots icon (to reveal menu options)
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        // show all the options based on conditional logic
        return user != null
            ? <PopupMenuEntry<PopupMenuOption>>[
                // PopupMenuItem(
                //   key: ordersKey,
                //   child: Text('Orders'.hardcoded),
                //   value: PopupMenuOption.orders,
                // ),
                PopupMenuItem(
                  key: accountKey,
                  child: Text(context.loc.account),
                  value: PopupMenuOption.account,
                ),
              ]
            : <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: signInKey,
                  child: Text(context.loc.signin),
                  value: PopupMenuOption.signIn,
                ),
              ];
      },
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          case PopupMenuOption.signIn:
            context.pushNamed(AppRoute.signIn.name);
            // context.go('/signIn');
            break;
          // case PopupMenuOption.orders:
          //   context.pushNamed(AppRoute.orders.name);
          //   // context.go('/orders');
          //   break;
          case PopupMenuOption.account:
            context.pushNamed(AppRoute.account.name);
            // context.go('/account');
            break;
        }
      },
    );
  }
}
