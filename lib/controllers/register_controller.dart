import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool isPassword = true.obs;
  RxBool isCPassword = true.obs;

  void changePasswordVisibility() {
    isPassword.value = !isPassword.value;
  }

  void changeCPasswordVisibility() {
    isCPassword.value = !isCPassword.value;
  }
}
