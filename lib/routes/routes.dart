import 'package:get/get.dart';
import 'package:signup_signin/screen/home_page.dart';
import 'package:signup_signin/screen/loginpage.dart';
import 'package:signup_signin/screen/registerpage.dart';

class Routes {
  static String login = '/';
  static String register = '/register';
  static String home = '/home';

  static List<GetPage> pages = [
    GetPage(
      name: login,
      page: () => const Loginpage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: register,
      page: () => const Registerpage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.cupertino,
    ),
  ];
}
