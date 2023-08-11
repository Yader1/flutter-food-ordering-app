import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';

import '../utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool backButtonExist;
  final Function? onBackPressed;

  const CustomAppBar({required this.title, this.backButtonExist = true, this.onBackPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      title: BigText(text: title, color: Colors.white),
      centerTitle: true,
      elevation: 0,
      leading: backButtonExist ? IconButton(
          onPressed: ()=>onBackPressed != null ? onBackPressed!():Navigator.pushReplacementNamed(context, 'initial'),
          icon: const Icon(Icons.arrow_back_ios)
      ) : const SizedBox()
    );
  }

  @override
  Size get preferredSize => const Size(500, 53);
}
