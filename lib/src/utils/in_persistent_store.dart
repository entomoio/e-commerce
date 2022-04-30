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

    if (_prefs.getString('profilePicture') == null) {
      _prefs.setString(
          'profilePicture', 'assets/images/profile pictures/profile0.png');
    }
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
      List<Item> currentList = getCartList();
      currentList.add(item);

      //to only update the quantity
      // List<Item> currentList = getCartList();
      // int index = currentList
      //     .indexWhere((element) => item.productId == element.productId);
      // if (index == -1) {
      //   currentList.add(item);
      // } else {
      //  currentList[index]
      //       .copyWith(quantity: item.quantity + currentList[index].quantity);
      // }

      cartItemsList = jsonEncode(currentList);
    }
  }

  String get name {
    return _prefs.getString('name') ?? '';
  }

  set name(String value) {
    _prefs.setString('name', 'Bom dia, ' + value.split(" ")[0] + '!');
    _prefs.setString('fullName', value);
  }

  String get fullName {
    return _prefs.getString('fullName') ?? '';
  }

  set fullName(String value) {
    _prefs.setString('fullName', value);
  }

  int get selectedCentralId {
    return _prefs.getInt('centralId') ?? 0;
  }

  set selectedCentralId(int value) {
    _prefs.setInt('centralId', value);
  }

  String get wifiPassword {
    return _prefs.getString('Password') ?? '';
  }

  set wifiPassword(String value) {
    _prefs.setString('Password', value);
  }

  String get profilePicture {
    return _prefs.getString('profilePicture') ?? '';
  }

  set profilePicture(String value) {
    _prefs.setString('profilePicture', value);
  }

  int get type {
    return _prefs.getInt('type') ?? 0;
  }

  set type(int value) {
    _prefs.setInt('type', value);
  }
}
