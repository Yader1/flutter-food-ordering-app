import 'package:flutter/material.dart';
import 'package:saiskarFood/controllers/order_controller.dart';
import 'package:saiskarFood/utils/colors.dart';
import 'package:get/get.dart';

import '../../utils/dimensiones.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const DeliveryOptions({
    Key? key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        return Row(
          children: [
            Radio(
                activeColor: AppColors.mainColor,
                value: value,
                groupValue: orderController.orderType,
                onChanged: (String? value)=>orderController.setDeliveryType(value!)
            ),
            SizedBox(width: Dimenciones.width10/2),
            Text(title, style: TextStyle(fontSize: Dimenciones.font16)),
            SizedBox(width: Dimenciones.width10/2),
            Text('(${(value == 'take away' || isFree)?'free':'\$${amount/10}'})', style: TextStyle(fontSize: Dimenciones.font16)),
          ],
        );
      }
    );
  }
}
