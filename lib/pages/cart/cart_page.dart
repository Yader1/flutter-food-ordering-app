import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/base/common_text_button.dart';
import 'package:flutter_tienda_comida/base/no_data_page.dart';
import 'package:flutter_tienda_comida/base/show_custom_snackbar.dart';
import 'package:flutter_tienda_comida/controllers/auth_controller.dart';
import 'package:flutter_tienda_comida/controllers/cart_controller.dart';
import 'package:flutter_tienda_comida/controllers/order_controller.dart';
import 'package:flutter_tienda_comida/controllers/popular_product_controller.dart';
import 'package:flutter_tienda_comida/controllers/recommended_product_controller.dart';
import 'package:flutter_tienda_comida/controllers/user_controller.dart';
import 'package:flutter_tienda_comida/models/place_order_model.dart';
import 'package:flutter_tienda_comida/pages/order/delivery_options.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_icon.dart';
import 'package:flutter_tienda_comida/widgets/app_text_field.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:flutter_tienda_comida/pages/order/payment_option_button.dart';
import 'package:flutter_tienda_comida/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
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
                                                Get.snackbar("Historial de productos",
                                                    "La revisión del producto no está disponible para los productos de historial",
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
                                        SizedBox(width: Dimenciones.width10,),
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
                                              SmallText(text: "Picante"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: "\$ ${cartController
                                                            .getItems[index]
                                                            .price}",
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimenciones
                                                            .height10/2,
                                                        bottom: Dimenciones
                                                            .height10/2,
                                                        left:
                                                            Dimenciones.width10,
                                                        right: Dimenciones
                                                            .width10/2),
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
                : const NoDataPage(text: "¡Tu carrito esta vacío!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController){
        _noteController.text = orderController.foodNote;
        return GetBuilder<CartController>(builder: (cartController) {
          return Container(
            height: Dimenciones.buttomHeightBar+50,
            padding: EdgeInsets.only(
                top: Dimenciones.height10,
                bottom: Dimenciones.height10,
                left: Dimenciones.width20,
                right: Dimenciones.width20
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimenciones.radius20 * 2),
                    topRight: Radius.circular(Dimenciones.radius20 * 2)
                )
            ),
            child: cartController.getItems.length > 0 ? Column(
              children: [
                InkWell(
                  onTap: () => showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_){
                        return Column(
                          children: [
                            Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.9,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(Dimenciones.radius20),
                                            topRight: Radius.circular(Dimenciones.radius20)
                                        )
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 520,
                                          padding: EdgeInsets.only(
                                              left: Dimenciones.width20,
                                              right: Dimenciones.width20,
                                              top: Dimenciones.height20
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const PaymentOptionButton(
                                                  iconData: Icons.money,
                                                  title: "Cash on delivery",
                                                  subTitle: "You pay after getting the delivery",
                                                  index: 0
                                              ),
                                              SizedBox(height: Dimenciones.height10),
                                              const PaymentOptionButton(
                                                  iconData: Icons.paypal_outlined,
                                                  title: "Digital payment",
                                                  subTitle: "Safer and faster way of payment",
                                                  index: 1
                                              ),
                                              SizedBox(height: Dimenciones.height30),
                                              Text("Delivery options", style: TextStyle(fontSize: Dimenciones.font16)),
                                              SizedBox(height: Dimenciones.height10/2),
                                              DeliveryOptions(
                                                  value: 'delivery',
                                                  title: "Home delivery",
                                                  amount: double.parse(Get.find<CartController>().totalAmount.toString()),
                                                  isFree: false
                                              ),
                                              SizedBox(height: Dimenciones.height10/2),
                                              DeliveryOptions(
                                                  value: 'take away',
                                                  title: "Take away",
                                                  amount: double.parse(Get.find<CartController>().totalAmount.toString()),
                                                  isFree: true
                                              ),
                                              SizedBox(height: Dimenciones.height30),
                                              Text("Additional info", style: TextStyle(fontSize: Dimenciones.font16)),
                                              SizedBox(height: Dimenciones.height10/2),
                                              AppTextField(
                                                textEditingController: _noteController,
                                                hintText: '',
                                                icon: Icons.note,
                                                maxLines: true,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            )
                          ],
                        );
                      }
                  ).whenComplete(()=>orderController.setFoodNote(_noteController.text.trim())),
                  child: const SizedBox(
                    width: double.maxFinite,
                    child: CommonTextButton(text: "Payment options"),
                  ),
                ),
                SizedBox(height: Dimenciones.height10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimenciones.height20,
                            bottom: Dimenciones.height20,
                            left: Dimenciones.width20,
                            right: Dimenciones.width20
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimenciones.radius20),
                            color: Colors.white
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: Dimenciones.width10 / 2),
                            BigText(text: "\$ ${cartController.totalAmount}"),
                            SizedBox(width: Dimenciones.width10 / 2),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            if (Get.find<LocationController>().addressList.isEmpty) {
                              Get.toNamed(RouteHelper.getAddressPage());
                            }else{
                              var location = Get.find<LocationController>().getUserAddress();
                              var cart = Get.find<CartController>().getItems;
                              var user = Get.find<UserController>().userModel;
                              PlaceOrderBody placeOrder = PlaceOrderBody(
                                  cart: cart,
                                  orderAmount: 100.0,
                                  distance: 10.0,
                                  scheduleAt: '',
                                  orderNote: orderController.foodNote,
                                  address: location.address,
                                  latitude: location.latitude,
                                  longitude: location.longitude,
                                  contactPersonName: user!.name,
                                  contactPersonNumber: user!.phone,
                                  orderType: orderController.orderType,
                                  paymentMethod: orderController.paymentIndex == 0 ? 'cash_on_delivery':'digital_payment'
                              );
                              Get.find<OrderController>().placeOrder(placeOrder, _callBack);
                            }
                          } else {
                            Get.toNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: const CommonTextButton(text: "Verificar"),
                      )
                    ]
                ),
              ],
            ) : Container(),
          );
        });
      })
    );
  }

  void _callBack(bool isSuccess, String message, String orderID){
    if(isSuccess){
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();

      if(Get.find<OrderController>().paymentIndex == 0){
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id));
      }

    } else {
      showCustomSnackBar(message);
    }
  }
}
