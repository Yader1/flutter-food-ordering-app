import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/base/custom_button.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:get/get.dart';
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
              Image.asset(status == 1 ? "assets/image/accept.png" : "assets/image/cancel.png", width: 100.0, height: 100.0),
              SizedBox(height: Dimenciones.height45),
              Text(
                status == 1 ? 'You placed the order successfully' : 'Your order failed',
                style: TextStyle(fontSize: Dimenciones.font26)
              ),
              SizedBox(height: Dimenciones.height20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimenciones.height20, vertical: Dimenciones.height20),
                child: Text(
                  status == 1 ? 'Successful order' : 'Failed order',
                  style: TextStyle(
                    fontSize: Dimenciones.font20,
                    color: Theme.of(context).disabledColor
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.all(Dimenciones.height20),
                child: CustomButton(
                  buttonText: 'Back to Home',
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
