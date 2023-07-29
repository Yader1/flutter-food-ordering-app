import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/models/order_model.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:get/get.dart';

import '../../controllers/order_controller.dart';
import '../../utils/dimensiones.dart';

class ViewOrder extends StatelessWidget {
  late bool isCurrent;
  ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController){
        if(orderController.isLoading == false){
          late List<OrderModel> orderList;
          if(orderController.currentOrderList.isNotEmpty){
            orderList = isCurrent ? orderController.currentOrderList.reversed.toList() :
            orderController.historyOrderList.reversed.toList();
          }

          return SizedBox(
            width: Dimenciones.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimenciones.width10/2, vertical: Dimenciones.height10/2),
              child: ListView.builder(itemCount: orderList.length, itemBuilder: (context, index){
                return InkWell(
                  onTap: (){},
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("#order ID     ${orderList[index].id}"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(Dimenciones.radius20/4),
                                    ),
                                    child: Container(
                                        margin: EdgeInsets.all(Dimenciones.height10/2),
                                        child: Text(
                                            "${orderList[index].orderStatus}",
                                            style: const TextStyle(
                                              color: Colors.white
                                            )
                                        )
                                    )
                                ),
                                SizedBox(height: Dimenciones.height10/2),
                                InkWell(
                                  onTap: (){},
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Dimenciones.radius20/4),
                                          border: Border.all(width: 1, color: AppColors.mainColor)
                                      ),
                                      child: Container(
                                          margin: EdgeInsets.all(Dimenciones.height10/2),
                                          child: const Text(
                                              "Track order",
                                              style: TextStyle(color: Colors.black)
                                          )
                                      )
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: Dimenciones.height10)
                    ],
                  ),
                );
              }),
            ),
          );
        } else {
          return Text("loading");
        }
      }),
    );
  }
}
