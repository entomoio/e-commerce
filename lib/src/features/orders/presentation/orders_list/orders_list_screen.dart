import 'package:localization_ecommerce/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:localization_ecommerce/src/common_widgets/responsive_center.dart';
import 'package:localization_ecommerce/src/constants/app_sizes.dart';
import 'package:localization_ecommerce/src/features/orders/presentation/orders_list/order_card.dart';
import 'package:localization_ecommerce/src/features/orders/domain/order.dart';

/// Shows the list of orders placed by the signed-in user.
class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    final orders = [
      Order(
        id: 'abc',
        userId: '123',
        items: {
          '1': 3,
          '2': 2,
          '3': 1,
        },
        orderStatus: OrderStatus.confirmed,
        orderDate: DateTime.now(),
        total: 104,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'.hardcoded),
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                'No previous orders'.hardcoded,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => ResponsiveCenter(
                      padding: const EdgeInsets.all(Sizes.p8),
                      child: OrderCard(
                        order: orders[index],
                      ),
                    ),
                    childCount: orders.length,
                  ),
                ),
              ],
            ),
    );
  }
}
