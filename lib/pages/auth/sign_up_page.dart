import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/base/custom_loader.dart';
import 'package:flutter_tienda_comida/base/show_custom_snackbar.dart';
import 'package:flutter_tienda_comida/controllers/auth_controller.dart';
import 'package:flutter_tienda_comida/models/signup_body_model.dart';
import 'package:flutter_tienda_comida/routes/route_helper.dart';
import 'package:flutter_tienda_comida/utils/colors.dart';
import 'package:flutter_tienda_comida/utils/dimensiones.dart';
import 'package:flutter_tienda_comida/widgets/app_text_field.dart';
import 'package:flutter_tienda_comida/widgets/big_text.dart';
import 'package:get/get.dart';

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
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in email address", title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
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
                //Email
                AppTextField(
                    textEditingController: emailController,
                    hintText: "Email",
                    icon: Icons.email_outlined),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Password
                AppTextField(
                  textEditingController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_rounded,
                  isObscure: true,
                ),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Name
                AppTextField(
                    textEditingController: nameController,
                    hintText: "Name",
                    icon: Icons.person),
                SizedBox(
                  height: Dimenciones.height20,
                ),
                //Phone
                AppTextField(
                    textEditingController: phoneController,
                    hintText: "Phone",
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
                    height: Dimenciones.screenHeight / 13,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimenciones.radius30),
                        color: AppColors.mainColor),
                    child: Center(
                      child: BigText(
                        text: "Sign up",
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
                        text: "Have an account already?",
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
                        text: "Sign up using one of the following methods",
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
                                "assets/image/" + singUpImages[index]),
                          ))),
                )
              ],
            ),
          ): const CustomLoader();
        }));
  }
}
