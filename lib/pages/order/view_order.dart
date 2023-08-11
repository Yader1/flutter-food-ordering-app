import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/base/custom_loader.dart';
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
                            Row(
                              children: [
                                Text("#order ID", style: TextStyle(fontSize: Dimenciones.font12, fontWeight: FontWeight.w700)),
                                SizedBox(width: Dimenciones.width10/2),
                                Text("#${orderList[index].id}"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimenciones.width10, vertical: Dimenciones.width10/2),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(Dimenciones.radius20/4),
                                    ),
                                    child: Text(
                                        "${orderList[index].orderStatus}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Dimenciones.font12
                                        )
                                    )
                                ),
                                SizedBox(height: Dimenciones.height10/2),
                                InkWell(
                                  onTap: (){},
                                  child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: Dimenciones.width10, vertical: Dimenciones.width10/2),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Dimenciones.radius20/4),
                                          border: Border.all(width: 1, color: AppColors.mainColor)
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.send_to_mobile, color: AppColors.mainColor),
                                          SizedBox(width: Dimenciones.width10/2),
                                          Text("Track order", style: TextStyle(color: AppColors.mainColor, fontSize: Dimenciones.font12))
                                        ],
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
          return const CustomLoader();
        }
      }),
    );
  }
}
