import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';


import 'home_page.dart';
import 'login_screen.dart';


class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4)).then((v) {
      User user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(LoginScreen());
      } else {
        RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(HomePage());
      }
    });
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/shoes_animation.json'),
      ),
    );
  }
}
