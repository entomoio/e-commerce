import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization_ecommerce/src/common_widgets/primary_button.dart';
import 'package:localization_ecommerce/src/constants/app_sizes.dart';
import 'package:localization_ecommerce/src/features/cart/domain/item.dart';
import 'package:localization_ecommerce/src/features/pdf/domain/product.dart';
import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';
import 'package:localization_ecommerce/src/routing/app_router.dart';
import 'package:localization_ecommerce/src/utils/in_persistent_store.dart';
import 'package:localization_ecommerce/src/utils/invoice_service.dart'
    if (dart.library.html) 'package:localization_ecommerce/src/utils/invoice_service_web.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PDF',
      home: InvoicePdfPage(),
    );
  }
}

class InvoicePdfPage extends StatefulWidget {
  const InvoicePdfPage({Key? key}) : super(key: key);

  @override
  State<InvoicePdfPage> createState() => _InvoicePdfPageState();
}

class _InvoicePdfPageState extends State<InvoicePdfPage> {
  final List<Item> cartItemsList = InPersistentStore().getCartList();

  final PdfInvoiceService service = PdfInvoiceService();
  List<Product> products = [
    Product("Apple", 15, 0, 1),
    Product("Pear", 13, 0, 2),
    Product("Banana", 17, 0, 3),
    Product("Pineapple", 12, 0, 4),
    Product("Mango", 12, 0, 5),
  ];
  int number = 0;

  @override
  Widget build(BuildContext context) {
    int i = 0;
    for (Product product in products) {
      products[i].quantity = cartItemsList
          .firstWhere((element) => int.parse(element.productId) == i + 1,
              orElse: () => Item(productId: (i + 1).toString(), quantity: 0))
          .quantity;
      i++;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final currentProduct = products[index];
                    return Row(
                      children: [
                        Expanded(child: Text(currentProduct.name)),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                  "Price: \$${currentProduct.price.toStringAsFixed(2)} "),
                              Text(
                                  "VAT ${currentProduct.vatInPercent.toStringAsFixed(0)} %")
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              // Expanded(
                              //   child: IconButton(
                              //     onPressed: () {
                              //       setState(() => currentProduct.quantity--);
                              //     },
                              //     icon: const Icon(Icons.remove),
                              //   ),
                              // ),
                              Expanded(
                                child: Text(
                                  currentProduct.quantity.toString(),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              // Expanded(
                              //   child: IconButton(
                              //     onPressed: () {
                              //       setState(() => currentProduct.quantity++);
                              //     },
                              //     icon: const Icon(Icons.add),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        gapH64,
                      ],
                    );
                  },
                  itemCount: products.length,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text("VAT"), Text("${getVat()} \$")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text("Total"), Text("${getTotal()} \$")],
              ),
              gapH16,
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: context.loc.invoice,
                  onPressed: () async {
                    InPersistentStore().cartItemsList = '';

                    final List<int> bytes =
                        await service.createInvoice(products);
                    // service.savePdfFile("invoice_$number", data);
                    // number++;
                    await service.saveAndLaunchFile(bytes, 'Invoice.pdf');

                    context.goNamed(AppRoute.home.name);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTotal() => products
      .fold(0.0,
          (double prev, element) => prev + (element.price * element.quantity))
      .toStringAsFixed(2);

  getVat() => products
      .fold(
          0.0,
          (double prev, element) =>
              prev +
              (element.price / 100 * element.vatInPercent * element.quantity))
      .toStringAsFixed(2);
}
