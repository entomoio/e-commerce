import 'dart:convert';

import 'package:localization_ecommerce/src/features/cart/domain/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: using a singleton now, update to dependency injection system (riverpod)
class InPersistentStore {
  static InPersistentStore instance = InPersistentStore._();
  factory InPersistentStore() {
    return instance;
  }

  InPersistentStore._(); //private constructor

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  String get cartItemsList {
    return _prefs.getString('cartItemsList') ?? '';
  }

  set cartItemsList(String list) {
    _prefs.setString('cartItemsList', list);
  }

//TODO: move this method to cart_repository
  List<Item> getCartList() {
    if (cartItemsList == '') {
      return [];
    }
    final decodedItemsList = List<Item>.from(
        jsonDecode(InPersistentStore().cartItemsList)
            .map((data) => Item.fromJson(data))
            .toList());
    return decodedItemsList;
  }

  //TODO: move this method to cart_repository
  void addCartItem(Item item) {
    if (cartItemsList == '') {
      cartItemsList = jsonEncode([item]);
    } else {
      // List<Item> currentList = getCartList();
      // currentList.add(item);

      List<Item> currentList = getCartList();
      int index = currentList
          .indexWhere((element) => item.productId == element.productId);
      if (index == -1) {
        currentList.add(item);
      } else {
        currentList[index] = currentList[index]
            .copyWith(quantity: item.quantity + currentList[index].quantity);
      }

      cartItemsList = jsonEncode(currentList);
    }
  }

  String get wifiPassword {
    return _prefs.getString('Password') ?? '';
  }

  set wifiPassword(String value) {
    _prefs.setString('Password', value);
  }
}
