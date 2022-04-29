import 'package:localization_ecommerce/src/features/products/domain/product.dart';

/// Test products to be used until a data source is implemented
const kTestProducts = [
  Product(
    id: '1',
    imageUrl: 'assets/products/apple.jpg',
    title: 'Apple',
    description: 'Fresh apples',
    price: 15,
    availableQuantity: 5,
    avgRating: 4.5,
    numRatings: 2,
  ),
  Product(
    id: '2',
    imageUrl: 'assets/products/pear.jpg',
    title: 'Pear',
    description: 'Fresh pears',
    price: 13,
    availableQuantity: 5,
    avgRating: 4,
    numRatings: 2,
  ),
  Product(
    id: '3',
    imageUrl: 'assets/products/banana.jpg',
    title: 'Banana',
    description: 'Fresh bananas',
    price: 17,
    availableQuantity: 5,
    avgRating: 5,
    numRatings: 2,
  ),
  Product(
    id: '4',
    imageUrl: 'assets/products/pineapple.jpg',
    title: 'Pineapple',
    description: 'Fresh pineapples',
    price: 12,
    availableQuantity: 5,
  ),
  Product(
    id: '5',
    imageUrl: 'assets/products/mango.jpg',
    title: 'Mango',
    description: 'Fresh mangoes',
    price: 12,
    availableQuantity: 10,
  ),
];
