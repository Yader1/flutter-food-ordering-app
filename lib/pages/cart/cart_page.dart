import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/controllers/cart_controller.dart';
import 'package:flutter_tienda_comida/pages/home/main_food_page.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_icon.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:flutter_tienda_comida/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimenciones.height20 * 3,
              left: Dimenciones.width20,
              right: Dimenciones.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimenciones.iconSize24,
                  ),
                  SizedBox(
                    width: Dimenciones.width20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimenciones.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimenciones.iconSize24,
                  ),
                ],
              )),
          Positioned(
              top: Dimenciones.height20 * 5,
              left: Dimenciones.width20,
              right: Dimenciones.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimenciones.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (cartController) {
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            return Container(
                              width: double.maxFinite,
                              height: Dimenciones.height20 * 5,
                              margin:
                                  EdgeInsets.only(bottom: Dimenciones.height10),
                              child: Row(
                                children: [
                                  Container(
                                    width: Dimenciones.height20 * 5,
                                    height: Dimenciones.height20 * 5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    cartController
                                                        .getItems[index].img!)),
                                        borderRadius: BorderRadius.circular(
                                            Dimenciones.radius20),
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: Dimenciones.width10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: Dimenciones.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController
                                              .getItems[index].name!,
                                          color: Colors.black54,
                                        ),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: cartController
                                                  .getItems[index].price
                                                  .toString(),
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: Dimenciones.height10,
                                                  bottom: Dimenciones.height10,
                                                  left: Dimenciones.width10,
                                                  right: Dimenciones.width10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimenciones.radius20),
                                                  color: Colors.white),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    child: Icon(Icons.remove,
                                                        color: AppColors
                                                            .signColor),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          Dimenciones.width10 /
                                                              2),
                                                  BigText(
                                                      text: _cartList[index]
                                                          .quantity
                                                          .toString()),
                                                  SizedBox(
                                                      width:
                                                          Dimenciones.width10 /
                                                              2),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: Icon(Icons.add,
                                                        color: AppColors
                                                            .signColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
