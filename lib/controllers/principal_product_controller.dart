import 'package:flutter_tienda_comida/data/repository/principal_product_repo.dart';
import 'package:flutter_tienda_comida/models/products_model.dart';
import 'package:get/get.dart';

class PrincipalProductController extends GetxController {
  final PrincipalProductRepo principalProductRepo;
  PrincipalProductController({required this.principalProductRepo});
  List<ProductModel> _principalProductList = [];
  List<ProductModel> get principalProductList => _principalProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPrincipalProductList() async {
    //Preparando los datos Get de los Especialidades
    Response response = await principalProductRepo.getPrincipalProductList();

    //Verificamos la respuestas si es positiva o fallida, si devuelve un 200 la respuesta es exitosa
    if (response.statusCode == 200) {
      _principalProductList = [];
      _principalProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}