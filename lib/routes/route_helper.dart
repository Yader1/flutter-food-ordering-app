import 'package:flutter_tienda_comida/models/order_model.dart';
import 'package:flutter_tienda_comida/pages/address/pick_address_map.dart';
import 'package:flutter_tienda_comida/pages/auth/sign_in_page.dart';
import 'package:flutter_tienda_comida/pages/cart/cart_page.dart';
import 'package:flutter_tienda_comida/pages/food/popular_food_detalle.dart';
import 'package:flutter_tienda_comida/pages/food/recommended_food_detail.dart';
import 'package:flutter_tienda_comida/pages/home/home_page.dart';
import 'package:flutter_tienda_comida/pages/payment/payment_page.dart';
import 'package:flutter_tienda_comida/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/address/add_address_page.dart';
import '../pages/payment/order_success_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";
  static const String payment = '/payment';
  static const String orderSuccess = '/order-successful';

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedeFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddressMap';
  static String getPaymentPage(String id, int userID) => '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID, String status) => '$orderSuccess?id=$orderID&status=$status';

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
    }),
    GetPage(name: pickAddressMap, page: (){
      PickAddressMap _pickAddress = Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: payment, page: ()=>PaymentPage(
        orderModel: OrderModel(
            id: int.parse(Get.parameters['id']!),
            userId: int.parse(Get.parameters['userID']!)
        )
    )),
    GetPage(name: orderSuccess, page: ()=>OrderSuccessPage(
      orderID: Get.parameters['id']!,
      status: Get.parameters["status"].toString().contains("success")?1:0,
    ))
  ];
}
