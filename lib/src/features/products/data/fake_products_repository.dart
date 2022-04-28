import 'package:localization_ecommerce/src/constants/test_products.dart';
import 'package:localization_ecommerce/src/features/products/domain/product.dart';

class FakeProductsRepository {
  //add a singleton
  FakeProductsRepository._(); //private constructor
  // prevents creating new instance: repo = FakeProductsRepository.getProductList()
  // enforces: FakeProductsRepository.instance.getProductList()

  static FakeProductsRepository instance = FakeProductsRepository._();
  List<Product> getProductList() {
    return kTestProducts;
  }

  Product? getProduct(String id) {
    return kTestProducts.firstWhere((product) => product.id == id);
  }
}
