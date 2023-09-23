import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/base/custom_app_bar.dart';
import 'package:flutter_tienda_comida/base/custom_loader.dart';
import 'package:flutter_tienda_comida/base/no_data_page.dart';
import 'package:flutter_tienda_comida/controllers/auth_controller.dart';
import 'package:flutter_tienda_comida/controllers/cart_controller.dart';
import 'package:flutter_tienda_comida/controllers/user_controller.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/account_widget.dart';
import 'package:flutter_tienda_comida/widgets/app_icon.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }
    return Scaffold(
      appBar: const CustomAppBar(title: "Perfil"),
      body: GetBuilder<UserController>(builder: (UserController) {
        return _userLoggedIn
            ? (UserController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimenciones.height20),
                    child: Column(children: [
                      //profile icon
                      AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimenciones.height45 + Dimenciones.height30,
                        size: Dimenciones.height15 * 10,
                      ),
                      SizedBox(
                        height: Dimenciones.height30,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //Name
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.person,
                                backgroundColor: AppColors.mainColor,
                                iconColor: Colors.white,
                                iconSize: Dimenciones.height10 * 5 / 2,
                                size: Dimenciones.height10 * 5,
                              ),
                              bigText:
                                  BigText(text: UserController.userModel!.name),
                            ),
                            SizedBox(
                              height: Dimenciones.height20,
                            ),
                            //Phone
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.phone_android,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimenciones.height10 * 5 / 2,
                                size: Dimenciones.height10 * 5,
                              ),
                              bigText:
                                  BigText(text: UserController.userModel!.phone),
                            ),
                            SizedBox(
                              height: Dimenciones.height20,
                            ),
                            //email
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.email_outlined,
                                backgroundColor: AppColors.yellowColor,
                                iconColor: Colors.white,
                                iconSize: Dimenciones.height10 * 5 / 2,
                                size: Dimenciones.height10 * 5,
                              ),
                              bigText:
                                  BigText(text: UserController.userModel!.email),
                            ),
                            SizedBox(
                              height: Dimenciones.height20,
                            ),
                            //address
                            GetBuilder<LocationController>(builder: (locationController){
                              if (_userLoggedIn && locationController.addressList.isEmpty){
                                return GestureDetector(
                                  onTap: (){
                                    Get.offNamed(RouteHelper.getAddressPage());
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.location_pin,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimenciones.height10 * 5 / 2,
                                      size: Dimenciones.height10 * 5,
                                    ),
                                    bigText: BigText(text: "Completa tu dirección"),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: (){
                                    Get.offNamed(RouteHelper.getAddressPage());
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.location_pin,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimenciones.height10 * 5 / 2,
                                      size: Dimenciones.height10 * 5,
                                    ),
                                    bigText: BigText(text: "Su dirección"),
                                  ),
                                );
                              }
                            }),
                            SizedBox(
                              height: Dimenciones.height20,
                            ),
                            //message
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.message_outlined,
                                backgroundColor: Colors.redAccent,
                                iconColor: Colors.white,
                                iconSize: Dimenciones.height10 * 5 / 2,
                                size: Dimenciones.height10 * 5,
                              ),
                              bigText: BigText(text: "Mensajes"),
                            ),
                            SizedBox(
                              height: Dimenciones.height20,
                            ),
                            //Cerrar sesion
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>().userLoggedIn()) {
                                  Get.find<AuthController>().clearSharedData();
                                  Get.find<CartController>().clear();
                                  Get.find<CartController>().clearCartHistory();
                                  Get.find<LocationController>().clearAddressList();
                                  Get.offNamed(RouteHelper.getSignInPage());
                                } else {}
                              },
                              child: AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.logout_outlined,
                                  backgroundColor: Colors.redAccent,
                                  iconColor: Colors.white,
                                  iconSize: Dimenciones.height10 * 5 / 2,
                                  size: Dimenciones.height10 * 5,
                                ),
                                bigText: BigText(text: "Cerrar sesión"),
                              ),
                            ),
                            SizedBox(
                              height: Dimenciones.height20,
                            ),
                          ],
                        ),
                      ))
                    ]),
                  )
                : const CustomLoader())
            : Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NoDataPage(
                      text: "",
                      imgPath: "assets/image/undraw_sign_up.svg",
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                          width: double.maxFinite,
                          height: Dimenciones.height20 * 4,
                          margin: EdgeInsets.only(
                              left: Dimenciones.width20,
                              right: Dimenciones.width20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimenciones.radius20),
                          ),
                          child: Center(
                            child: BigText(
                              text: "Iniciar sesión",
                              color: Colors.white,
                              size: Dimenciones.font26,
                            ),
                          )),
                    )
                  ],
                )),
              );
      }),
    );
  }
}
