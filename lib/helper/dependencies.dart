import 'package:flutter_tienda_comida/controllers/cart_controller.dart';
import 'package:flutter_tienda_comida/controllers/popular_product_controller.dart';
import 'package:flutter_tienda_comida/controllers/recommended_product_controller.dart';
import 'package:flutter_tienda_comida/data/api/api_client.dart';
import 'package:flutter_tienda_comida/data/repository/cart_repo.dart';
import 'package:flutter_tienda_comida/data/repository/popular_product_repo.dart';
import 'package:flutter_tienda_comida/data/repository/recommended_product_repo.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //Api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //Repos
  //Llamar nuestros repositorios
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

  //Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
