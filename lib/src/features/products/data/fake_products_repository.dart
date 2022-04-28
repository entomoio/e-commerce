import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/constants/test_products.dart';
import 'package:localization_ecommerce/src/features/products/domain/product.dart';

class FakeProductsRepository {
  // //singletons makes our code hard to test (they are harcoded dependencies)
  // FakeProductsRepository._();
  // //private constructor
  // // prevents creating new instance: repo = FakeProductsRepository.getProductList()
  // // enforces: FakeProductsRepository.instance.getProductList()

  // static FakeProductsRepository instance = FakeProductsRepository._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

//REST API
  Future<List<Product>> fetchProductsList() {
    return Future.value(_products);
  }

//realtime API (websockets, Firebase)
  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  // return FakeProductsRepository.instance;
  return FakeProductsRepository();
});
