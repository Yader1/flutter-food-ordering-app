import '../data/repository/drink_product_repo.dart';
import '../models/products_model.dart';

import 'package:get/get.dart';

class DrinksProductController extends GetxController {
  final DrinksProductRepo drinksProductRepo;
  DrinksProductController({required this.drinksProductRepo});
  List<ProductModel> _drinksProductList = [];
  List<ProductModel> get drinksProductList => _drinksProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getDrinksProductList() async {
    //Preparando los datos Get de los Especialidades
    Response response = await drinksProductRepo.getDrinkProductList();

    //Verificamos la respuestas si es positiva o fallida, si devuelve un 200 la respuesta es exitosa
    if (response.statusCode == 200) {
      _drinksProductList = [];
      _drinksProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}