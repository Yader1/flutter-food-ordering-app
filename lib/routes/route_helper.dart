import 'package:flutter_tienda_comida/pages/auth/sign_in_page.dart';
import 'package:flutter_tienda_comida/pages/cart/cart_page.dart';
import 'package:flutter_tienda_comida/pages/food/popular_food_detalle.dart';
import 'package:flutter_tienda_comida/pages/food/recommended_food_detail.dart';
import 'package:flutter_tienda_comida/pages/home/home_page.dart';
import 'package:flutter_tienda_comida/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/address/add_address_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedeFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashPage()),
    //Ruta principal
    GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    //Ruta de inicio
    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        }, transition: Transition.fade),
    //Ruta de poplares
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetalle(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    //Ruta de recomendados
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendeFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    //Ruta de carrito
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
     //Ruta a mapa
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    })
  ];
}
