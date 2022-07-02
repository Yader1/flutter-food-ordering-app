import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/home/food_page_body.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:flutter_tienda_comida/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        //Showing the header
        Container(
          child: Container(
            //Encabezado de la pagina principal
            margin: EdgeInsets.only(top: Dimenciones.height45, bottom: Dimenciones.height15),
            padding: EdgeInsets.only(left: Dimenciones.width20, right: Dimenciones.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "Bengladesh", color: AppColors.mainColor,), //Pais
                    //Hacer un tipo lista del departamento
                    Row(children: [
                      SmallText(text: "Narsingdi", color: Colors.black54),
                      Icon(Icons.arrow_drop_down_circle_rounded)
                    ],)
                  ], 
                ),
                Center(
                  child: Container(
                    width: Dimenciones.height45,
                    height: Dimenciones.height45,
                    child: Icon(Icons.search, color: Colors.white, size: Dimenciones.iconSize24,),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimenciones.radius15), color: AppColors.mainColor),
                  )
                )
              ],),
          ),),
        //Showing the body
        FoodPageBody()
      ]),
    );
  }
}
