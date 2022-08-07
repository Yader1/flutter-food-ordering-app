import 'package:flutter_tienda_comida/data/repository/cart_repo.dart';
import 'package:flutter_tienda_comida/models/cart_model.dart';
import 'package:flutter_tienda_comida/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  void addItem(ProductModel product, int quantity) {
    _items.putIfAbsent(product.id!, () {
      print("Adding item to the cart");
      return CartModel(
        id: product.id,
        name: product.name,
        price: product.price,
        img: product.img,
        quantity: quantity,
        isExit: true,
        time: DateTime.now().toString(),
      );
    });
  }
}
