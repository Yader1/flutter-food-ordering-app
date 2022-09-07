import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/base/no_data_page.dart';
import 'package:flutter_tienda_comida/controllers/cart_controller.dart';
import 'package:flutter_tienda_comida/controllers/popular_product_controller.dart';
import 'package:flutter_tienda_comida/controllers/recommended_product_controller.dart';
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
          //Body
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
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
                                    margin: EdgeInsets.only(
                                        bottom: Dimenciones.height10),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);

                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex,
                                                      "cartpage"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History product",
                                                    "Product review is not avaible for history products",
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedeFood(
                                                        recommendedIndex,
                                                        "cartpage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimenciones.height20 * 5,
                                            height: Dimenciones.height20 * 5,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstants.BASE_URL +
                                                            AppConstants
                                                                .UPLOAD_URL +
                                                            cartController
                                                                .getItems[index]
                                                                .img!)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimenciones.radius20),
                                                color: Colors.white),
                                          ),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: "\$ " +
                                                        cartController
                                                            .getItems[index]
                                                            .price
                                                            .toString(),
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimenciones
                                                            .height10,
                                                        bottom: Dimenciones
                                                            .height10,
                                                        left:
                                                            Dimenciones.width10,
                                                        right: Dimenciones
                                                            .width10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimenciones
                                                                    .radius20),
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
                                                          child: Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor),
                                                        ),
                                                        SizedBox(
                                                            width: Dimenciones
                                                                    .width10 /
                                                                2),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity
                                                                .toString()),
                                                        SizedBox(
                                                            width: Dimenciones
                                                                    .width10 /
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
                : NoDataPage(text: "Your cart is empty!");
          })
        ],
      ),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimenciones.buttomHeightBar,
          padding: EdgeInsets.only(
              top: Dimenciones.height30,
              bottom: Dimenciones.height30,
              left: Dimenciones.width20,
              right: Dimenciones.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimenciones.radius20 * 2),
                  topRight: Radius.circular(Dimenciones.radius20 * 2))),
          child: cartController.getItems.length > 0 ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimenciones.height20,
                  bottom: Dimenciones.height20,
                  left: Dimenciones.width20,
                  right: Dimenciones.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenciones.radius20),
                  color: Colors.white),
              child: Row(
                children: [
                  SizedBox(width: Dimenciones.width10 / 2),
                  BigText(text: "\$ " + cartController.totalAmount.toString()),
                  SizedBox(width: Dimenciones.width10 / 2),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                cartController.addToHistory();
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimenciones.height20,
                    bottom: Dimenciones.height20,
                    left: Dimenciones.width20,
                    right: Dimenciones.width20),
                child: BigText(
                  text: "Check out",
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimenciones.radius20),
                    color: AppColors.mainColor),
              ),
            )
          ]): Container(),
        );
      }),
    );
  }
}
