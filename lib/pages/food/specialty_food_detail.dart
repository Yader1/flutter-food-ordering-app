import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/exandable_text_widget.dart';
import '../../controllers/specialty_product_controller.dart';

class SpecialtyFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const SpecialtyFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<SpecialtyProductController>().specialtyProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              //Apagamos el button de atras que genera por defecto
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page == "cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.back();
                      }
                    },
                    child: const AppIcon(icon: Icons.clear),
                  ),
                  //AppIcon(icon: Icons.shopping_cart_outlined),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                        onTap: () {
                          if (controller.totalItems >= 1) {
                            Get.toNamed(RouteHelper.getCartPage());
                          }
                        },
                        child: Stack(
                          children: [
                            const AppIcon(icon: Icons.shopping_cart_outlined),
                            Get.find<PopularProductController>().totalItems >= 1
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
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimenciones.radius20),
                      topRight: Radius.circular(Dimenciones.radius20),
                    ),
                  ),
                  child: Center(
                      child: BigText(
                    text: product.name!,
                    size: Dimenciones.font26,
                  )),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(left: Dimenciones.width20, right: Dimenciones.width20),
                  child: ExandableTextWidget(text: product.description!),
                )
              ]),
            ),
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimenciones.width20 * 2.5,
                  right: Dimenciones.width20 * 2.5,
                  top: Dimenciones.height10,
                  bottom: Dimenciones.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconSize: Dimenciones.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.remove,
                      )),
                  BigText(
                    text: "\$ ${product.price!} X ${controller.inCartItems} ",
                    color: AppColors.mainBlackColor,
                    size: Dimenciones.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimenciones.iconSize24,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.add),
                  )
                ],
              ),
            ),
            Container(
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimenciones.height20,
                          bottom: Dimenciones.height20,
                          left: Dimenciones.width20,
                          right: Dimenciones.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimenciones.radius20),
                          color: Colors.white),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimenciones.height20,
                          bottom: Dimenciones.height20,
                          left: Dimenciones.width20,
                          right: Dimenciones.width20
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimenciones.radius20),
                            color: AppColors.mainColor),
                        child: BigText(
                          text: "\$ ${product.price!} | Añadir a la cesta",
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
            ),
          ]);
        }));
  }
}
