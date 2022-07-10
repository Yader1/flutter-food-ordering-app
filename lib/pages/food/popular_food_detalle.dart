import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/pages/home/main_food_page.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_column.dart';
import 'package:flutter_tienda_comida/widgets/app_icon.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:flutter_tienda_comida/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetalle extends StatelessWidget {
  const PopularFoodDetalle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage("assets/image/food0.jpg"),
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
                      Get.to(() => MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  AppIcon(icon: Icons.shopping_cart_outlined),
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
                    AppColumn(text: "Chinese Side"),
                    SizedBox(
                      height: Dimenciones.height20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimenciones.height20,
                    ),
                    //exapandable text widget
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExandableTextWidget(
                            text:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
                Icon(Icons.remove, color: AppColors.signColor),
                SizedBox(width: Dimenciones.width10 / 2),
                BigText(text: "0"),
                SizedBox(width: Dimenciones.width10 / 2),
                Icon(Icons.add, color: AppColors.signColor)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: Dimenciones.height20,
                bottom: Dimenciones.height20,
                left: Dimenciones.width20,
                right: Dimenciones.width20),
            child: BigText(
              text: "\$10 | Add to cart",
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimenciones.radius20),
                color: AppColors.mainColor),
          ),
        ]),
      ),
    );
  }
}
