import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/constants.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/pages/my_screens/al_products_screen.dart';
import 'package:shop_app_final/pages/my_screens/favorite_screen.dart';
import 'package:shop_app_final/pages/my_screens/profile_screen.dart';

import '../../controller/controller/router_helper.dart';
import 'cart_screen.dart';
import 'home_page.dart';

class BottmNavigationBar extends StatefulWidget {
  const BottmNavigationBar({Key key}) : super(key: key);

  @override
  State<BottmNavigationBar> createState() => _BottmNavigationBarState();
}

class _BottmNavigationBarState extends State<BottmNavigationBar> {
  final int _pageCount = 4;
  int _pageIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.home,
                size: 30,
                color: _pageIndex == 0 ? kPrimaryColor : Colors.white),
            Icon(Icons.favorite,
                size: 30,
                color: _pageIndex == 1 ? kPrimaryColor : Colors.white),
            Icon(Icons.format_list_bulleted_rounded,
                size: 30,
                color: _pageIndex == 2 ? kPrimaryColor : Colors.white),
            Icon(Icons.account_circle,
                size: 30,
                color: _pageIndex == 3 ? kPrimaryColor : Colors.white),
          ],
          color: kPrimaryColor.withOpacity(0.8),
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _body());
  }

  Widget _body() {
    return Stack(
      children: List<Widget>.generate(_pageCount, (int index) {
        return IgnorePointer(
          ignoring: index != _pageIndex,
          child: Opacity(
            opacity: _pageIndex == index ? 1.0 : 0.0,
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (_) => ppage(index),
                  settings: settings,
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget ppage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return const FavoriteProductScreen();
      case 2:
        return const AllProductScreen();
      case 3:
        return ProfilePage(forEdit: false,);
    }
    throw "Invalid index $index";
  }
}
