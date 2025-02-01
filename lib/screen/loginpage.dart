import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:signup_signin/controllers/login_controller.dart';
import 'package:signup_signin/services/auth_service.dart';

import '../routes/routes.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            Align(
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Sign in to your account",
              style: TextStyle(
                fontSize: 22,
                color: Color(0xff004643),
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Email Address",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (val) =>
                          val!.isNotEmpty ? "Enter email" : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "Enter your email address",
                        hintStyle: const TextStyle(
                          color: Color(0xffC4C4C4),
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        )),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(() {
                      return TextFormField(
                        obscureText: controller.isPassword.value,
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.changePasswordVisibility();
                            },
                            icon: (controller.isPassword.value)
                                ? Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    CupertinoIcons.eye_solid,
                                    color: Colors.grey,
                                  ),
                          ),
                          hintText: "Enter your password",
                          hintStyle: const TextStyle(
                            color: Color(0xffC4C4C4),
                            fontWeight: FontWeight.w400,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 6.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        " Forgot Password?",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff757575),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        if (email.isNotEmpty && password.isNotEmpty) {
                          String msg = await AuthService.authService
                              .loginUser(email: email, password: password);

                          if (msg == "Success") {
                            Get.offNamed(Routes.home);
                            Get.snackbar(
                              'Login',
                              '$email is login successfully',
                              backgroundColor: Colors.green.shade200,
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              msg,
                              backgroundColor: Colors.red.shade200,
                            );
                          }
                        } else {
                          Get.snackbar(
                            'Error',
                            "Please fill email and password!!",
                            backgroundColor: Colors.red.shade200,
                          );
                        }
                      },
                      child: Container(
                        height: 48.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff004643),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "other way to sign in",
                      style: TextStyle(color: Color(0xff757575)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        String msg =
                            await AuthService.authService.signInWithGoogle();

                        if (msg == "Success") {
                          Get.offNamed(Routes.home);
                          Get.snackbar(
                            'Login',
                            'login successfully',
                            backgroundColor: Colors.green.shade200,
                          );
                        } else {
                          Get.snackbar(
                            'Error',
                            msg,
                            backgroundColor: Colors.red.shade200,
                          );
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            Image(image: AssetImage('assets/google.webp'))
                                .image,
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Don't have an account ? ",
                        style: TextStyle(color: Color(0xff757575)),
                        children: [
                          TextSpan(
                            text: "Create Account",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.register);
                              },
                            style: const TextStyle(
                              color: Color(0xff004643),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
