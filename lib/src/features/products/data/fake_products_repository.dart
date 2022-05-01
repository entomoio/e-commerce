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
  Future<List<Product>> fetchProductsList() async {
    // await Future.delayed(const Duration(milliseconds: 500));
    // throw Exception('Connection problems');
    return Future.value(_products);
  }

//realtime API (websockets, Firebase)
  Stream<List<Product>> watchProductsList() async* {
    //async* converts this to a stream generator
    await Future.delayed(const Duration(milliseconds: 100));
    // return Stream.value(_products);
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  // // as a singleton
  // return FakeProductsRepository.instance;
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  // debugPrint('created productsListStreamProvider');
  final producsRepository = ref.watch(productsRepositoryProvider);
  return producsRepository.watchProductsList();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final producsRepository = ref.watch(productsRepositoryProvider);
  return producsRepository.fetchProductsList();
});

final productProvider = StreamProvider.autoDispose.family<Product?, String>(
  (ref, id) {
    // debugPrint('created productProvider with id: $id');
    // ref.onDispose(() => debugPrint('disposed productProvider'));
    final productsRepository = ref.watch(productsRepositoryProvider);
    return productsRepository.watchProduct(id);
  },
  // disposeDelay: const Duration(seconds: 5),
  // cacheTime: const Duration(seconds: 5),
);
