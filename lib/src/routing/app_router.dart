import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:localization_ecommerce/src/features/authentication/presentation/account/account_screen.dart';
import 'package:localization_ecommerce/src/features/checkout/presentation/checkout_screen.dart';
import 'package:localization_ecommerce/src/features/pdf/data/pdf_screen.dart';
import 'package:localization_ecommerce/src/features/reviews/presentation/leave_review_screen/leave_review_screen.dart';
import 'package:localization_ecommerce/src/routing/not_found_screen.dart';
import 'package:localization_ecommerce/src/features/orders/presentation/orders_list/orders_list_screen.dart';
import 'package:localization_ecommerce/src/features/products/presentation/product_screen/product_screen.dart';
import 'package:localization_ecommerce/src/features/products/presentation/products_list/products_list_screen.dart';
import 'package:localization_ecommerce/src/features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import 'package:localization_ecommerce/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:localization_ecommerce/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  product,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
  pdf,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.location == '/signIn') {
          return '/';
        }
      } else {
        if (state.location == '/account' || state.location == '/orders') {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
          path: '/',
          name: AppRoute.home.name,
          builder: (context, state) => const ProductsListScreen(),
          routes: [
            GoRoute(
              path: 'product/:id',
              name: AppRoute.product.name,
              builder: (context, state) {
                final productId = state.params['id']!;
                return ProductScreen(productId: productId);
              },
              routes: [
                GoRoute(
                    path: 'review',
                    name: AppRoute.leaveReview.name,
                    pageBuilder: (context, state) {
                      final productId = state.params['id']!;
                      return MaterialPage(
                        fullscreenDialog: true,
                        child: LeaveReviewScreen(productId: productId),
                      );
                    }),
              ],
            ),
            GoRoute(
              path: 'cart',
              name: AppRoute.cart.name,
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: ShoppingCartScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'checkout',
                  name: AppRoute.checkout.name,
                  pageBuilder: (context, state) => const MaterialPage(
                    fullscreenDialog: true,
                    child: CheckoutScreen(),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'pdf',
              name: AppRoute.pdf.name,
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: InvoicePdfPage(),
              ),
            ),
            GoRoute(
              path: 'orders',
              name: AppRoute.orders.name,
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: OrdersListScreen(),
              ),
            ),
            GoRoute(
              path: 'account',
              name: AppRoute.account.name,
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: AccountScreen(),
              ),
            ),
            GoRoute(
              path: 'signIn',
              name: AppRoute.signIn.name,
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: EmailPasswordSignInScreen(
                  formType: EmailPasswordSignInFormType.signIn,
                ),
              ),
            ),
          ]),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
