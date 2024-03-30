import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/specialty_product_controller.dart';
import '../../pages/home/food_page_body.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../../controllers/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

Future<void> _loadResource () async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    await Get.find<SpecialtyProductController>().getSpecialtyProductList();
}
class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _loadResource,
        child: Column(children: [
          //Showing the header
          Container(
            //Encabezado de la pagina principal
            margin: EdgeInsets.only(top: Dimenciones.height45, bottom: Dimenciones.height15),
            padding: EdgeInsets.only(left: Dimenciones.width20, right: Dimenciones.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "Nicaragua",
                      color: AppColors.mainColor,
                    ), //Pais
                    //Hacer un tipo lista del departamento
                    Row(
                      children: [
                        SmallText(text: "Bilwi", color: Colors.black54),
                        SizedBox(width: Dimenciones.width10),
                        const Icon(Icons.arrow_drop_down_circle_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                    child: Container(
                  width: Dimenciones.height45,
                  height: Dimenciones.height45,
                  // ignore: sort_child_properties_last
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: Dimenciones.iconSize24,
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimenciones.radius15),
                      color: AppColors.mainColor),
                ))
              ],
            ),
          ),
          //Showing the body
          const Expanded(
            child: SingleChildScrollView(
            child: FoodPageBody(),
          ))
        ]));
  }
}
