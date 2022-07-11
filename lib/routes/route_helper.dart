import 'package:flutter_tienda_comida/pages/food/popular_food_detalle.dart';
import 'package:flutter_tienda_comida/pages/food/recommended_food_detail.dart';
import 'package:flutter_tienda_comida/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial() => '$initial';
  static String getPopularFood() => '$popularFood';
  static String getRecommendedeFood() => '$recommendedFood';

  static List<GetPage> routes = [
    //Ruta principal
    GetPage(name: initial, page: () => MainFoodPage()),
    //Ruta de poplares
    GetPage(
        name: popularFood,
        page: () {
          return PopularFoodDetalle();
        },
        transition: Transition.fadeIn),
    //Ruta de recomendados
    GetPage(
        name: recommendedFood,
        page: () {
          return RecommendeFoodDetail();
        },
        transition: Transition.fadeIn),
  ];
}
