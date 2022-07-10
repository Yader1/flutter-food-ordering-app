import 'package:flutter_tienda_comida/controllers/popular_product_controller.dart';
import 'package:flutter_tienda_comida/data/api/api_client.dart';
import 'package:flutter_tienda_comida/data/repository/popular_product_repo.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //Api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //Repos
  //Llamar nuestros repositorios
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //Controllers
  Get.lazyPut(() => PupularProductController(popularProductRepo: Get.find()));
}
