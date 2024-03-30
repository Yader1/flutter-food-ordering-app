import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_app_bar.dart';
import '../../controllers/principal_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class FoodPrincipalPage extends StatefulWidget {
  const FoodPrincipalPage({super.key});

  @override
  State<FoodPrincipalPage> createState() => _FoodPrincipalPageState();
}

class _FoodPrincipalPageState extends State<FoodPrincipalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Principales"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<PrincipalProductController>(builder: (principalProduct) {
          return principalProduct.isLoaded ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: principalProduct.principalProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getPrincipalFood(index, "home"));
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimenciones.width20,
                    right: Dimenciones.width20,
                    bottom: Dimenciones.height10
                  ),
                  child: Row(
                    children: [
                      //Seccion de imagens
                      Container(
                        width: Dimenciones.listViewImgSize,
                        height: Dimenciones.listViewImgSize,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mainColor.withOpacity(0.2),
                              blurRadius: 10.0,
                              offset: const Offset(4, 8)
                            )
                          ],
                          borderRadius: BorderRadius.circular(Dimenciones.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              AppConstants.BASE_URL + AppConstants.UPLOAD_URL + principalProduct.principalProductList[index].img!
                            ),
                          ),
                        ),
                      ),
                      //Contenedor de textos
                      Expanded(
                        child: Container(
                        height: Dimenciones.listViewTextContSize,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mainColor.withOpacity(0.4),
                              blurRadius: 10.0,
                              offset: const Offset(2, 5)
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimenciones.radius20),
                            bottomRight: Radius.circular(Dimenciones.radius20),
                          ),
                          color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimenciones.width10, right: Dimenciones.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: principalProduct.principalProductList[index].name!),
                                SizedBox(height: Dimenciones.height10),
                                SizedBox(
                                  height: Dimenciones.height10,
                                  child: SmallText(text: principalProduct.principalProductList[index].description!)
                                ),
                                SizedBox(height: Dimenciones.height10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                      icon: Icons.circle_sharp,
                                      text: "Normal",
                                      iconColor: AppColors.iconColor1
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.location_on,
                                      text: "1.2Km",
                                      iconColor: AppColors.mainColor
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.access_time_rounded,
                                      text: "32min",
                                      iconColor: AppColors.iconColor2
                                    ),
                                  ],
                                )
                              ]
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                ),
              );
            },
          ) : Center(child: CircularProgressIndicator(color: AppColors.mainColor));
        }),
      )
    );
  }
}