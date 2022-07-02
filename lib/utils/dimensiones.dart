import 'package:get/get.dart';

class Dimenciones {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

// Alturas dinamicas padding y margin
  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 56.27;
  static double height15 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;
  
// Anchos dinamicos padding y margin
  static double width10 = screenHeight / 84.4;
  static double width20 = screenHeight / 56.27;
  static double width15 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;

  //Tamaño de letra
  static double font20 = screenHeight / 42.2;

  //Radius
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;
  static double radius15 = screenHeight / 56.27;

  //Tamaño de icono
  static double iconSize24 = screenHeight / 35.17;
}
