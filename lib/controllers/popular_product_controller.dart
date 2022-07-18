import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/data/repository/popular_product_repo.dart';
import 'package:flutter_tienda_comida/models/products_model.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  Future<void> getPopularProductList() async {
    //Preparando los datos Get de los populares
    Response response = await popularProductRepo.getPopularProductList();

    //Verificamos la respuestas si es positiva o fallida, si devuelve un 200 la respuesta es exitosa
    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
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
    if (quantity < 0) {
      //Mensaje para el usuario
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > 20) {
      //Mensaje para el usuario
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  //Metodo para verificar que se inicie todo y se restablesca los valores
  void initProduct() {
    _quantity = 0;
    
  }
}