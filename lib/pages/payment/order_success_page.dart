import 'package:flutter/material.dart';

import '../../base/custom_button.dart';
import '../../routes/route_helper.dart';

import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({Key? key, required this.orderID, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(status == 0){
      Future.delayed(const Duration(seconds: 1), (){

      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimenciones.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(status == 1 ? Icons.check_circle_outline : Icons.warning_amber_outlined, size: 100.0, color: AppColors.mainColor),
              SizedBox(height: Dimenciones.height30),
              Text(
                status == 1 ? 'Hiciste el pedido exitosamente' : 'Tu pedido falló',
                style: TextStyle(fontSize: Dimenciones.font20)
              ),
              SizedBox(height: Dimenciones.height20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimenciones.height20, vertical: Dimenciones.height10),
                child: Text(
                  status == 1 ? 'Pedido exitoso' : 'Pedido fallido',
                  style: TextStyle(
                    fontSize: Dimenciones.font20,
                    color: Theme.of(context).disabledColor
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: Dimenciones.height10),
              Padding(
                padding: EdgeInsets.all(Dimenciones.height10),
                child: CustomButton(
                  buttonText: 'Volver al inicio',
                  onPressed: ()=>Get.offAllNamed(RouteHelper.getInitial()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
