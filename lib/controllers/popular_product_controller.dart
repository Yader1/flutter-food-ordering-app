import 'package:flutter/material.dart';

import '../controllers/cart_controller.dart';
import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';

import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //Variables para seleccionar la cantidad de un producto
  int _quantity = 0;
  int get quantity => _quantity;

  //Variables para mostrar cuantas orden hay en el carito
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    //Preparando los datos Get de los populares
    Response response = await popularProductRepo.getPopularProductList();

    //Verificamos la respuestas si es positiva o fallida, si devuelve un 200 la respuesta es exitosa
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  //Cantidad del producto a pedir, aunmenta al darle el clic en mas
  void setQuantity(bool isIncrement) {
    //Verdadero aunmenta y falso disminue
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }

    update();
  }

  //Verificamos que la cantidad nosea negativa
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      //Mensaje para el usuario
      Get.snackbar(
        "Recuento de elementos",
        "¡No se puede reducir más!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      //Mensaje para el usuario
      Get.snackbar(
        "Recuento de elementos",
        "¡No puedes agregar más!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  //Metodo para verificar que se inicie todo y se restablesca los valores
  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;

    var exist = false;
    exist = _cart.existInCart(product);

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    //Condicion si hay datos previamentes guardados
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print('The id is ' + value.id.toString());
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
