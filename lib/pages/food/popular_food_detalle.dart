import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/controllers/cart_controller.dart';
import 'package:flutter_tienda_comida/controllers/popular_product_controller.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_column.dart';
import 'package:flutter_tienda_comida/widgets/app_icon.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:flutter_tienda_comida/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetalle extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetalle({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Fondo Img de populares
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimenciones.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!),
                )),
              )),
          //Bottun de atras y carrito
          Positioned(
              left: Dimenciones.width20,
              right: Dimenciones.width20,
              top: Dimenciones.height45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page == "cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                        onTap: () {
                          //if (controller.totalItems >= 1)
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
                ],
              )),
          //Contenido o descripcion
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            top: Dimenciones.popularFoodImgSize - 20,
            child: Container(
                padding: EdgeInsets.only(
                  left: Dimenciones.width20,
                  right: Dimenciones.width20,
                  top: Dimenciones.height20,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimenciones.radius20),
                      topLeft: Radius.circular(Dimenciones.radius20),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimenciones.height20,
                    ),
                    BigText(text: "Introducir"),
                    SizedBox(
                      height: Dimenciones.height20,
                    ),
                    //exapandable text widget
                    Expanded(
                      child: SingleChildScrollView(
                          child:
                              ExandableTextWidget(text: product.description!)),
                    ),
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProducts) {
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                  GestureDetector(
                    onTap: () {
                      popularProducts.setQuantity(false);
                    },
                    child: Icon(Icons.remove, color: AppColors.signColor),
                  ),
                  SizedBox(width: Dimenciones.width10 / 2),
                  BigText(text: popularProducts.inCartItems.toString()),
                  SizedBox(width: Dimenciones.width10 / 2),
                  GestureDetector(
                    onTap: () {
                      popularProducts.setQuantity(true);
                    },
                    child: Icon(Icons.add, color: AppColors.signColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                popularProducts.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimenciones.height20,
                    bottom: Dimenciones.height20,
                    left: Dimenciones.width20,
                    right: Dimenciones.width20),
                child: BigText(
                  text: "\$ ${product.price!} | Añadir a la cesta",
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimenciones.radius20),
                    color: AppColors.mainColor),
              ),
            )
          ]),
        );
      }),
    );
  }
}
