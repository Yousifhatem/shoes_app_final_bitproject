import 'package:flutter/material.dart';
import 'package:shop_app_final/components/coustom_bottom_nav_bar.dart';


import '../../enums.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: const Center(
        child: Text('profile screen'),
      ),

      //bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
