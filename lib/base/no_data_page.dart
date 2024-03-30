import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage({super.key, required this.text, this.imgPath="assets/image/undraw_empty_cart.svg"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /*
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height*0.22,
          width: MediaQuery.of(context).size.width*0.22,
        ),
        */
        SvgPicture.asset(
          imgPath,
          height: MediaQuery.of(context).size.height*0.22,
          width: MediaQuery.of(context).size.width*0.22,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height*0.0175,
            color: Theme.of(context).disabledColor
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
