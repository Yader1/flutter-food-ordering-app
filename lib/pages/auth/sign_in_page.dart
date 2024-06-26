import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../pages/auth/sign_up_page.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
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
        showCustomSnackBar("Escriba la dirección del teléfono", title: "Dirección de teléfono");
      } else if (!GetUtils.isNum(phone)) {
        showCustomSnackBar("Escriba una dirección de teléfono válida",
            title: "Dirección de teléfono válida");
      } else if (password.isEmpty) {
        showCustomSnackBar("Escriba su contraseña", title: "Clave");
      } else if (password.length < 6) {
        showCustomSnackBar("La contraseña no puede tener menos de seis caracteres",
            title: "Clave");
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
                SizedBox(
                    height: Dimenciones.screenHeight * 0.25,
                    child: Center(
                      child: Image.asset("assets/image/logo.png"),
                    )),
                //Welcome
                Container(
                  margin: EdgeInsets.only(left: Dimenciones.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hola",
                        style: TextStyle(
                          fontSize:
                              Dimenciones.font20 * 3 + Dimenciones.font20 / 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Iniciar sesión en su cuenta",
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
                  textInputType: TextInputType.number,
                  textEditingController: phoneController,
                  hintText: "Teléfono",
                  icon: Icons.phone_iphone
                ),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Password
                AppTextField(
                  textEditingController: passwordController,
                  hintText: "Contraseña",
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
                            text: "Iniciar sesión en su cuenta",
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
                    height: Dimenciones.screenHeight / 15,
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(Dimenciones.radius30),
                        color: AppColors.mainColor,
                        boxShadow: [
                          BoxShadow(
                            //blurRadius: 3,
                            //spreadRadius: 1,
                            blurRadius: 5.0,
                            offset: const Offset(0, 5),
                            color: AppColors.mainColor.withOpacity(0.5),
                          )
                        ]
                      ),
                    child: Center(
                      child: BigText(
                        text: "Iniciar sesión",
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
                        text: "¿No tienes una cuenta?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimenciones.font20,
                        ),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage(),
                                transition: Transition.fade),
                          text: " Crear",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlackColor,
                            fontSize: Dimenciones.font20,
                          ))
                    ])),
              ],
            ),
          ): const CustomLoader();
        }));
  }
}
