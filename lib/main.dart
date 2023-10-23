import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:saiskarFood/controllers/cart_controller.dart';
import 'package:saiskarFood/controllers/popular_product_controller.dart';
import 'package:saiskarFood/controllers/recommended_product_controller.dart';
import 'package:saiskarFood/routes/route_helper.dart';
import 'package:saiskarFood/utils/colors.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'controllers/dessert_product_controller.dart';
import 'controllers/drinks_product_controller.dart';
import 'controllers/principal_product_controller.dart';
import 'controllers/specialty_product_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'helper/notification_helper.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<dynamic> myBackgroudMessageHeandler(RemoteMessage message) async {
  /*print(
      "onBackgroud: ${message.notification?.title}/${message.notification?.body}/"
          "${message.notification?.titleLocKey}"
  );*/
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*try{
    if(GetPlatform.isMobile){
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroudMessageHeandler);
    }
  }catch(e){
    if(kDebugMode){
      print(e.toString());
    }
  }*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetBuilder<PrincipalProductController>(builder: (_) {
            return GetBuilder<SpecialtyProductController>(builder: (_) {
                return GetBuilder<DrinksProductController>(builder: (_) {
                    return GetBuilder<DessertProductController>(builder: (_) {
                        return GetMaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'Saiskar Food',
                          //home: SignInPage(),
                          initialRoute: RouteHelper.getSplashPage(),
                          getPages: RouteHelper.routes,
                          theme: ThemeData(
                            primaryColor: AppColors.mainColor,
                            //fontFamily: ""
                          ),
                        );
                      }
                    );
                  }
                );
              }
            );
          }
        );
      });
    });
  }
}