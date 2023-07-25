import 'package:flutter_tienda_comida/controllers/auth_controller.dart';
import 'package:flutter_tienda_comida/controllers/cart_controller.dart';
import 'package:flutter_tienda_comida/controllers/order_controller.dart';
import 'package:flutter_tienda_comida/controllers/popular_product_controller.dart';
import 'package:flutter_tienda_comida/controllers/recommended_product_controller.dart';
import 'package:flutter_tienda_comida/controllers/user_controller.dart';
import 'package:flutter_tienda_comida/data/api/api_client.dart';
import 'package:flutter_tienda_comida/data/repository/auth_repo.dart';
import 'package:flutter_tienda_comida/data/repository/cart_repo.dart';
import 'package:flutter_tienda_comida/data/repository/order_repo.dart';
import 'package:flutter_tienda_comida/data/repository/popular_product_repo.dart';
import 'package:flutter_tienda_comida/data/repository/recommended_product_repo.dart';
import 'package:flutter_tienda_comida/data/repository/user_repo.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/location_controller.dart';
import '../data/repository/location_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //Api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //Repos
  //Llamar nuestros repositorios
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //Controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}
