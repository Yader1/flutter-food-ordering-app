import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';
import '../utils/dimensiones.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  bool maxLines;
  TextInputType textInputType; 

  AppTextField({
    super.key,
    this.isObscure = false,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.maxLines = false,
    this.textInputType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimenciones.height20, right: Dimenciones.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimenciones.radius15),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.2),
            )
          ]),
      child: TextField(
        keyboardType: textInputType,
        maxLines: maxLines ? 3 : 1,
        obscureText: isObscure?true : false,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppColors.mainColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimenciones.radius15),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimenciones.radius15),
              borderSide: const BorderSide(width: 1.0, color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimenciones.radius15),
          ),
        ),
      ),
    );
  }
}
