import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:signup_signin/controllers/register_controller.dart';

import '../services/auth_service.dart';

class Registerpage extends StatelessWidget {
  const Registerpage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController cPasswordController = TextEditingController();

    RegisterController controller = Get.put(RegisterController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Align(
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Create new account",
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
                      height: 15.h,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Confirm Password",
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
                        obscureText: controller.isCPassword.value,
                        controller: cPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.changeCPasswordVisibility();
                            },
                            icon: (controller.isCPassword.value)
                                ? Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    CupertinoIcons.eye_solid,
                                    color: Colors.grey,
                                  ),
                          ),
                          hintText: "Enter your conform password",
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
                        String cPassword = cPasswordController.text.trim();

                        if (email.isNotEmpty &&
                            password.isNotEmpty &&
                            cPassword.isNotEmpty) {
                          if (password == cPassword) {
                            String msg = await AuthService.authService
                                .registerUser(email: email, password: password);

                            log("MESSAGE : $msg");

                            if (msg == "Success") {
                              Get.back();
                              Get.snackbar(
                                'Register',
                                '$email is register successfully',
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
                              'Password and Conform Password not match',
                              backgroundColor: Colors.red.shade200,
                            );
                          }
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please fill email and password!!',
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
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Text.rich(
              TextSpan(
                text: "Already have an account ? ",
                style: TextStyle(color: Color(0xff757575)),
                children: [
                  TextSpan(
                    text: "Back to Sign In",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.back();
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
    );
  }
}
