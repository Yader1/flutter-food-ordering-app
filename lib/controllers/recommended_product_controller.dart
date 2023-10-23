import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    //Preparando los datos Get de los populares
    Response response = await recommendedProductRepo.getRecommendedProductList();

    //Verificamos la respuestas si es positiva o fallida, si devuelve un 200 la respuesta es exitosa
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}