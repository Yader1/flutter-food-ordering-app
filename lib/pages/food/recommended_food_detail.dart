import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/controllers/recommended_product_controller.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_icon.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:flutter_tienda_comida/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendeFoodDetail extends StatelessWidget {
  final int pageId;
 RecommendeFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
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
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(
                  text: product.name!,
                  size: Dimenciones.font26,
                )),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimenciones.radius20),
                    topRight: Radius.circular(Dimenciones.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                child: ExandableTextWidget(
                  text:product.description!
                ),
                margin: EdgeInsets.only(
                    left: Dimenciones.width20, right: Dimenciones.width20),
              )
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: EdgeInsets.only(
              left: Dimenciones.width20 * 2.5,
              right: Dimenciones.width20 * 2.5,
              top: Dimenciones.height10,
              bottom: Dimenciones.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcon(
                  iconSize: Dimenciones.iconSize24,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.remove),
              BigText(
                text: "\$ ${product.price!} X 0 ",
                color: AppColors.mainBlackColor,
                size: Dimenciones.font26,
              ),
              AppIcon(
                  iconSize: Dimenciones.iconSize24,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.add),
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
              child: Icon(
                Icons.favorite,
                color: AppColors.mainColor,
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
      ]),
    );
  }
}
