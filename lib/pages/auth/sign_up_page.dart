import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    //Lista de img de opcion de sesion
    var singUpImages = [
      "f.png",
      "g.png",
    ];

    void _registration(AuthController authController) {
  
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Escriba su nombre", title: "Nombre");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Escriba su número de teléfono", title: "Número de teléfono");
      } else if (email.isEmpty) {
        showCustomSnackBar("Escriba la dirección de correo electrónico", title: "Dirección de correo electrónico");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Escriba una dirección de correo electrónico válida",
            title: "Dirección de email válida");
      } else if (password.isEmpty) {
        showCustomSnackBar("Escriba su contraseña", title: "contraseña");
      } else if (password.length < 6) {
        showCustomSnackBar("La contraseña no puede tener menos de seis caracteres",
            title: "contraseña");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);

        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                //Email
                AppTextField(
                    textEditingController: emailController,
                    hintText: "Correo electrónico",
                    icon: Icons.email_outlined),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Password
                AppTextField(
                  textEditingController: passwordController,
                  hintText: "Contraseña",
                  icon: Icons.password_rounded,
                  isObscure: true,
                ),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Name
                AppTextField(
                    textEditingController: nameController,
                    hintText: "Nombre",
                    icon: Icons.person),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Phone
                AppTextField(
                  textInputType: TextInputType.number,
                  textEditingController: phoneController,
                  hintText: "Teléfono",
                  icon: Icons.phone_android),
                SizedBox(
                  height: Dimenciones.height20,
                ),

                //Button
                GestureDetector(
                  onTap: () {
                    _registration(_authController);
                  },
                  child: Container(
                    width: Dimenciones.screenWidth / 2,
                    height: Dimenciones.screenHeight / 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimenciones.radius30),
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
                        text: "Inscribirse",
                        color: Colors.white,
                        size: Dimenciones.font20 + Dimenciones.font20 / 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimenciones.height10,
                ),

                //Mensaje despues del button
                RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "¿Ya tienes una cuenta?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimenciones.font20,
                        ))),
                SizedBox(
                  height: Dimenciones.screenHeight * 0.05,
                ),

                //Opciones de crear una cuenta
                RichText(
                    text: TextSpan(
                        text: "Regístrese usando uno de los siguientes métodos",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimenciones.font16,
                        ))),
                Wrap(
                  children: List.generate(
                      2,
                      (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimenciones.radius30,
                            backgroundImage: AssetImage(
                                "assets/image/${singUpImages[index]}"),
                          ))),
                )
              ],
            ),
          ): const CustomLoader();
        }));
  }
}
