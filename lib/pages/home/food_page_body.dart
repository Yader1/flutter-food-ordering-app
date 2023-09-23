import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/controllers/popular_product_controller.dart';
import 'package:flutter_tienda_comida/models/products_model.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_column.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:flutter_tienda_comida/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/dessert_product_controller.dart';
import '../../controllers/drinks_product_controller.dart';
import '../../controllers/principal_product_controller.dart';
import '../../controllers/specialty_product_controller.dart';
import 'food_dessert_page.dart';
import 'food_drink_page.dart';
import 'food_principal_page.dart';
import 'food_specialty_page.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimenciones.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Seccion Slider
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimenciones.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      // Calculamos el tamaño dej JSON que nos devuleve la API
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        }),
        //Menu de la carta
        SizedBox(
          height: Dimenciones.height20,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimenciones.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Menu del restaurante"),
              SizedBox(
                width: Dimenciones.width10/1.2,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimenciones.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Comidas sabrosas"),
              )
            ],
          ),
        ),
        //Cuadros de opciones del menu
        SizedBox(height: Dimenciones.height10),
        SizedBox(
          width: Dimenciones.screenWidth,
          height: Dimenciones.height45*4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await Get.find<SpecialtyProductController>().getSpecialtyProductList();
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FoodSpecialtyPage()),
                      );
                    });
                  },
                  child: Container(
                    width: Dimenciones.screenWidth/2.2,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.4),
                          blurRadius: 10.0,
                          offset: const Offset(2, 5)
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(Dimenciones.radius20)),
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/especialidad.png',
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: Dimenciones.height10),
                        BigText(text: "Especialidad", size: Dimenciones.font20, color: AppColors.mainColor),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Dimenciones.width10),
                GestureDetector(
                  onTap: () async {
                    await Get.find<PrincipalProductController>().getPrincipalProductList();
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FoodPrincipalPage()),
                      );
                    });
                  },
                  child: Container(
                    width: Dimenciones.screenWidth/2.2,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.4),
                          blurRadius: 10.0,
                          offset: const Offset(2, 5)
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(Dimenciones.radius20)),
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/principal.png',
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: Dimenciones.height10),
                        BigText(text: "Principales", size: Dimenciones.font20, color: AppColors.mainColor),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
        SizedBox(
          width: Dimenciones.screenWidth,
          height: Dimenciones.height45*4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await Get.find<DessertProductController>().getDessertProductList();
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FoodDessertPage()),
                      );
                    });
                  },
                  child: Container(
                    width: Dimenciones.screenWidth/2.2,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.4),
                          blurRadius: 10.0,
                          offset: const Offset(2, 5)
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(Dimenciones.radius20)),
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/postre.png',
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: Dimenciones.height10),
                        BigText(text: "Postres", size: Dimenciones.font20, color: AppColors.mainColor),
                      ],
                    ),
                  ),
                ),
               
                SizedBox(width: Dimenciones.width10),
                GestureDetector(
                  onTap: () async {
                    await Get.find<DrinksProductController>().getDrinksProductList();
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FoodDrinkPage()),
                      );
                    });
                  },
                  child: Container(
                    width: Dimenciones.screenWidth/2.2,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mainColor.withOpacity(0.4),
                          blurRadius: 10.0,
                          offset: const Offset(2, 5)
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(Dimenciones.radius20)),
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/bebidas.png',
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: Dimenciones.height10),
                        BigText(text: "Bebidas", size: Dimenciones.font20, color: AppColors.mainColor),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),

        //Recomendaciones de comidas
        //Lista de comidas e imagenes
        /*GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedeFood(index, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimenciones.width20,
                            right: Dimenciones.width20,
                            bottom: Dimenciones.height10),
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
                                borderRadius:
                                    BorderRadius.circular(Dimenciones.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstants.BASE_URL +
                                      AppConstants.UPLOAD_URL +
                                      recommendedProduct
                                          .recommendedProductList[index].img!),
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
                                padding: EdgeInsets.only(
                                    left: Dimenciones.width10,
                                    right: Dimenciones.width10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                      SizedBox(height: Dimenciones.height10),
                                      SizedBox(
                                        height: Dimenciones.height10,
                                        child: SmallText(text: recommendedProduct.recommendedProductList[index].description!)
                                        ),
                                      SizedBox(height: Dimenciones.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.2Km",
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: "32min",
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      )
                                    ]),
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })*/
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimenciones.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimenciones.width10, right: Dimenciones.width10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimenciones.radius30),
                    color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      //Como es una Img de un servidorse utiliza el siguente Widget
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularProduct.img!))),
            ),
          ),
          //Diseño del espacio de la informacion de la barra principal
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimenciones.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimenciones.width30,
                  right: Dimenciones.width30,
                  bottom: Dimenciones.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimenciones.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainColor.withOpacity(0.4),
                      blurRadius: 10.0,
                      offset: const Offset(2, 5)
                    )
                  ]),
              //Informacion de la barra
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimenciones.height15, left: 15, right: 15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
