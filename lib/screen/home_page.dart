import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_signin/services/auth_service.dart';

import '../controllers/home_controller.dart';
import '../routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName:
                  Text(AuthService.authService.auth.currentUser!.email ?? ""),
              accountEmail: Text(""),
            ),
            ListTile(
              onTap: () {
                controller.signOut();
                Get.offNamed(Routes.login);
              },
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home Page"),
      ),
    );
  }
}
