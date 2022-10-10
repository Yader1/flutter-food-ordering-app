import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/base/custom_loader.dart';
import 'package:flutter_tienda_comida/pages/auth/sign_up_page.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_text_field.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("Type in phone address", title: "Phone address");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        showCustomSnackBar("Type in a valid phone address",
            title: "Valid phone address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading ? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: Dimenciones.screenHeight * 0.05,
                ),
                Container(
                    height: Dimenciones.screenHeight * 0.25,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80.0,
                        backgroundImage: AssetImage("assets/image/logo.jpeg"),
                      ),
                    )),
                //Welcome
                Container(
                  margin: EdgeInsets.only(left: Dimenciones.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize:
                              Dimenciones.font20 * 3 + Dimenciones.font20 / 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Sign into your account",
                        style: TextStyle(
                            fontSize: Dimenciones.font20,
                            color: Colors.grey[500]),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Email
                AppTextField(
                    textEditingController: phoneController,
                    hintText: "Email",
                    icon: Icons.email_outlined),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Password
                AppTextField(
                  textEditingController: passwordController,
                  hintText: "Password",
                  isObscure: true,
                  icon: Icons.password_rounded,
                ),
                SizedBox(
                  height: Dimenciones.height20,
                ),

                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(
                        text: TextSpan(
                            text: "Sing into your account",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimenciones.font20,
                            ))),
                    SizedBox(
                      width: Dimenciones.width20,
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimenciones.screenHeight * 0.05,
                ),

                //Button
                GestureDetector(
                  onTap: () {
                    _login(authController);
                  },
                  child: Container(
                    width: Dimenciones.screenWidth / 2,
                    height: Dimenciones.screenHeight / 13,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimenciones.radius30),
                        color: AppColors.mainColor),
                    child: Center(
                      child: BigText(
                        text: "Sign in",
                        color: Colors.white,
                        size: Dimenciones.font20 + Dimenciones.font20 / 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimenciones.screenHeight * 0.05,
                ),
                //Opciones de crear una cuenta
                RichText(
                    text: TextSpan(
                        text: "Don\'t an account?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimenciones.font20,
                        ),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage(),
                                transition: Transition.fade),
                          text: " Create",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlackColor,
                            fontSize: Dimenciones.font20,
                          ))
                    ])),
              ],
            ),
          ): CustomLoader();
        }));
  }
}
