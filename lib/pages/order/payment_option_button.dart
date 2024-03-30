import 'package:flutter/material.dart';

import '../../controllers/order_controller.dart';
import '../../utils/dimensiones.dart';

import 'package:get/get.dart';

import '../../utils/colors.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subTitle;
  final int index;

  const PaymentOptionButton({
    Key? key,
    required this.iconData,
    required this.title,
    required this.subTitle,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimenciones.height10/2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimenciones.radius20/4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!,
                    blurRadius: 5,
                    spreadRadius: 1
                )
              ]
          ),
          child: ListTile(
            leading: Icon(iconData, size: 40, color: _selected ? AppColors.mainColor : Theme.of(context).disabledColor),
            title: Text(title, style: TextStyle(fontSize: Dimenciones.font20)),
            subtitle: Text(subTitle, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: Dimenciones.font16, color: Theme.of(context).disabledColor)
            ),
            trailing: _selected ? Icon(Icons.check_circle, color: AppColors.mainColor) : null,
          ),
        ),
      );
    });
  }
}
