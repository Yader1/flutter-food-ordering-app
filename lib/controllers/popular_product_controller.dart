import 'package:flutter_tienda_comida/data/repository/popular_product_repo.dart';
import 'package:flutter_tienda_comida/models/products_model.dart';
import 'package:get/get.dart';

class PupularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PupularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    //Preparando los datos Get de los populares
    Response response = await popularProductRepo.getPopularProductList();

    //Verificamos la respuestas si es positiva o fallida, si devuelve un 200 la respuesta es exitosa
    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.add(Product.fromJson(response.body).products);
      update();
    } else {}
  }
}
