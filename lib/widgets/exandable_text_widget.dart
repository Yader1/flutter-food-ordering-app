import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/dimensiones.dart';
import './small_text.dart';

class ExandableTextWidget extends StatefulWidget {
  final String text;
  ExandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExandableTextWidget> createState() => _ExandableTextWidgetState();
}

class _ExandableTextWidgetState extends State<ExandableTextWidget> {
  late String firsHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimenciones.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firsHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else{
      firsHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color: AppColors.paraColor, size: Dimenciones.font16, text: firsHalf) : Column(
        children: [
          SmallText(height: 1.8, color: AppColors.paraColor, size: Dimenciones.font16, text: hiddenText?(firsHalf+"...") : (firsHalf+secondHalf),),
          InkWell(
            onTap:() {
              setState(() {
                hiddenText =! hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: "Mostrar más", color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down : Icons.arrow_drop_up, color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
