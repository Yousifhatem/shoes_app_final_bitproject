

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';

import '../../../size_config.dart';
import '../home_page.dart';
import '../login_screen.dart';
import 'components/body.dart';



class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    // Future.delayed(const Duration(seconds: 4)).then((v) {
    //   User user = FirebaseAuth.instance.currentUser;
    //   if (user == null) {
    //     RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(LoginScreen());
    //   } else {
    //     RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(HomePage());
    //   }
    // });

    return Scaffold(
      body: Body(),
    );
  }
}
