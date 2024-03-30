import '../data/repository/specialty_product_repo.dart';
import '../models/products_model.dart';

import 'package:get/get.dart';

class SpecialtyProductController extends GetxController {
  final SpecialtyProductRepo specialtyProductRepo;
  SpecialtyProductController({required this.specialtyProductRepo});
  List<ProductModel> _specialtyProductList = [];
  List<ProductModel> get specialtyProductList => _specialtyProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getSpecialtyProductList() async {
    //Preparando los datos Get de los Especialidades
    Response response = await specialtyProductRepo.getSpecialtyProductList();

    //Verificamos la respuestas si es positiva o fallida, si devuelve un 200 la respuesta es exitosa
    if (response.statusCode == 200) {
      _specialtyProductList = [];
      _specialtyProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}