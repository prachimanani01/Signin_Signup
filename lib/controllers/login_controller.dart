import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isPassword = true.obs;

  void changePasswordVisibility() {
    isPassword.value = !isPassword.value;
  }
}
