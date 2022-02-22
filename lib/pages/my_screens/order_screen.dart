import 'package:flutter/material.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/pages/my_screens/home_page.dart';

import 'bottom_navigaion_screen.dart';

class OroderScreen extends StatelessWidget {
  const OroderScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
          },
        ),
        backgroundColor: Colors.white,
        title: const Text('Order Screen', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
