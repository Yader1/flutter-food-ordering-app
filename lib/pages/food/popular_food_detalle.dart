import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_icon.dart';

class PopularFoodDetalle extends StatelessWidget {
  const PopularFoodDetalle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ) 
              ),
          )),
          //Bottun de atras y carrito
          Positioned(
            left: Dimenciones.width20,
            right: Dimenciones.width20,
            top: Dimenciones.height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            )
          ),
          //Contenido o descripcion
          Positioned(
            right: 0,
            left: 0,
            top: Dimenciones.popularFoodImgSize,
            
            child: Container(

          ),),
        ],
      ),
    );
  }
}