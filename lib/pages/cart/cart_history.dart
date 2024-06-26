import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../controllers/cart_controller.dart';
import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
 
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderTimeToList();

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
      );
    }

    return Scaffold(
      body: Column(children: [
        Container(
          height: Dimenciones.height10 * 10,
          color: AppColors.mainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimenciones.height45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(text: "Historial del carrito", color: Colors.white),
              GestureDetector(
                onTap: () {Get.toNamed(RouteHelper.getCartPage());},
                child: AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                ),
              ),
              /*
              GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                        onTap: () {
                            Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 5.5,
                                    top: 3,
                                    child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                      color: Colors.white,
                                    ))
                                : Container(),
                          ],
                        ));
                  })
              */
            ],
          ),
        ),
        //Body
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getCartHistoryList().length > 0 ? Expanded(
            child: Container(
              margin: EdgeInsets.only(top: Dimenciones.height20, left: Dimenciones.width20, right: Dimenciones.width20),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for (int i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        height: Dimenciones.height30 * 4,
                        margin: EdgeInsets.only(bottom: Dimenciones.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            timeWidget(listCounter),
                            SizedBox(height: Dimenciones.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index) {
                                    if (listCounter < getCartHistoryList.length) {
                                      listCounter++;
                                    }
                                    return index <= 2 ? Container(
                                      height: Dimenciones.height20 * 4,
                                      width: Dimenciones.height20 * 4,
                                      margin: EdgeInsets.only(right: Dimenciones.width10 / 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimenciones.radius15 / 2),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            AppConstants.BASE_URL + AppConstants.UPLOAD_URL +
                                              getCartHistoryList[listCounter - 1].img!
                                          )
                                        )
                                      ),
                                    ) : Container();
                                  }),
                                ),
                                Container(
                                  height: Dimenciones.height20 * 5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(text: "Total", color: AppColors.titleColor),
                                      BigText(text: itemsPerOrder[i].toString() + "Elementos", color: AppColors.titleColor),
                                      GestureDetector(
                                        onTap: () {
                                          var orderTime = cartOrderTimeToList();
                                          Map<int, CartModel> moreOrder = {};
                                          for (int j = 0; j < getCartHistoryList.length; j++) {
                                            if (getCartHistoryList[j].time == orderTime[i]) {
                                              moreOrder.putIfAbsent(
                                                getCartHistoryList[j].id!,
                                                () => CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                              );
                                            }
                                          }
                                          Get.find<CartController>().setItems = moreOrder;
                                          Get.find<CartController>().addToCartList();
                                          Get.toNamed(RouteHelper.getCartPage());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimenciones.width10, vertical: Dimenciones.height10 / 2
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimenciones.radius15 / 3),
                                            border: Border.all(width: 1, color: AppColors.mainColor),
                                          ),
                                          child: SmallText(text: "Uno mas", color: AppColors.mainColor),
                                        ),
                                      )
                                    ]
                                  ),
                                )
                              ],
                            )
                          ]
                        ),
                      )
                  ],
                ),
              ),
            ),
          ) : SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: const Center(
              child: NoDataPage(
                text: "¡Hasta ahora no has comprado nada!",
                imgPath: "assets/image/undraw_empty_cart.svg",
              ),
            ),
          );
        })
      ]),
    );
  }
}
