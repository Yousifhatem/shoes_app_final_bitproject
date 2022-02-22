import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/pages/my_screens/add_new_category.dart';
import 'package:shop_app_final/pages/my_screens/address_screen.dart';
import 'package:shop_app_final/pages/my_screens/al_products_screen.dart';
import 'package:shop_app_final/pages/my_screens/cart_screen.dart';
import 'package:shop_app_final/pages/my_screens/favorite_screen.dart';
import 'package:shop_app_final/pages/my_screens/order_screen.dart';
import 'package:shop_app_final/pages/my_screens/profile_screen.dart';
import 'dart:math' as math;

import '../../constants.dart';
import '../../controller/controller/provider/language_provider.dart';
import 'add_new_product.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: Directionality(
          textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
          child: Drawer(
            child: Consumer<AppProvider>(
              builder: (context, provider, x) {
                return ListView(
                  children: [
                    UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(color: kPrimaryColor),
                        currentAccountPicture:
                            provider.loggedFireUser.imageUser == null
                                ? const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        'assets/images/empty_avatar.png'),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        provider.loggedFireUser.imageUser),
                                  ),
                        accountName: Text(provider.loggedFireUser.name),
                        accountEmail: Text(provider.loggedFireUser.email)),
                    ListTile(
                      onTap: () {
                        RouterHelper.routerHelper
                            .routingToSpecificWidget(ProfilePage(
                          forEdit: false,
                        ));
                      },
                      title: Text(lan.getTexts('my_profile')),
                      leading: const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        RouterHelper.routerHelper
                            .routingToSpecificWidget(const OroderScreen());
                      },
                      title: Text(lan.getTexts('my_orders')),
                      leading: const Icon(
                        Icons.shopping_bag,
                        color: kPrimaryColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        RouterHelper.routerHelper
                            .routingToSpecificWidgetWithoutPop(CartScreen());
                      },
                      title: Text(lan.getTexts('shopping_cart')),
                      leading: const Icon(
                        Icons.shopping_cart_sharp,
                        color: kPrimaryColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        RouterHelper.routerHelper
                            .routingToSpecificWidgetWithoutPop(
                                const FavoriteProductScreen());
                      },
                      title: Text(lan.getTexts('favorite')),
                      leading: const Icon(
                        Icons.favorite,
                        color: kPrimaryColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        RouterHelper.routerHelper
                            .routingToSpecificWidgetWithoutPop(AddressScreen());
                      },
                      title: Text(lan.getTexts('my_address')),
                      leading: const Icon(
                        Icons.location_on,
                        color: kPrimaryColor,
                      ),
                    ),
                    const Divider(),
                    Column(
                      children: [
                        ListTile(
                          title: Text(lan.getTexts('change_language')),
                          leading: const Icon(
                            Icons.language,
                            color: kPrimaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: (lan.isEn ? 0.w : 20.w),
                              left: (lan.isEn ? 20.w : 0.w),
                              bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                (lan.getTexts('arabic')).toString(),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Switch(
                                value: Provider.of<LanguageProvider>(context,
                                        listen: true)
                                    .isEn,
                                onChanged: (newVal) {
                                  Provider.of<LanguageProvider>(context,
                                          listen: false)
                                      .changeLan(newVal);
                                  Navigator.of(context).pop();
                                },
                                inactiveTrackColor: kPrimaryColor,
                                //activeTrackColor: kPrimaryColor,
                              ),
                              Text(
                                (lan.getTexts('english')).toString(),
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 10.h,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    ListTile(
                      onTap: () {
                        provider.logout();
                      },
                      title: Text(lan.getTexts('logout')),
                      leading: const Icon(Icons.logout),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          excludeHeaderSemantics: false,
          actions: [
            Consumer<AppProvider>(
              builder: (context, provider, x) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Badge(
                    showBadge: provider.cartProducts.isNotEmpty,
                    position: BadgePosition(top: 0.h, end: 2.w),
                    animationType: BadgeAnimationType.fade,
                    badgeColor: Colors.redAccent,
                    badgeContent: Text(
                      provider.cartProducts.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      onPressed: () => RouterHelper.routerHelper
                          .routingToSpecificWidgetWithoutPop(CartScreen()),
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Image.asset(
                "assets/icons/menu-bar.png",
                color: Colors.black,
                width: 30.w,
                height: 30.h,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
        ),
        body: Consumer<AppProvider>(
          builder: (context, provider, x) {
            return Directionality(
              textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lan.getTexts('brands'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          visible:
                              Provider.of<AppProvider>(context, listen: false)
                                      .loggedFireUser
                                      ?.isAdmin ??
                                  false,
                          child: Expanded(
                            child: GestureDetector(
                              onTap: () {
                                RouterHelper.routerHelper
                                    .routingToSpecificWidget(AddNewCategory());
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                height: 50.h,
                                child: Text(
                                  lan.getTexts('add_brands'),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300.h,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: provider.allCategories == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : provider.allCategories.isEmpty
                            ? Center(
                                child: Text(lan.getTexts('no_product_found')),
                              )
                            : ListView.builder(
                                itemCount: provider.allCategories.length,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 16.h),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 230.w,
                                      margin: EdgeInsets.only(right: 16.w),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 25.0.h),
                                            child: provider.buildBackground(
                                                index, 230, () {
                                              RouterHelper.routerHelper
                                                  .routingToSpecificWidgetWithoutPop(
                                                      AddNewProduct(
                                                categoryId: provider
                                                    .allCategories[index].id,
                                              ));
                                            },
                                                provider
                                                    .allCategories[index].id),
                                          ),
                                          Positioned(
                                            bottom: 130.h,
                                            right: 10.w,
                                            child: Hero(
                                              tag: provider
                                                  .allCategories[index].id,
                                              child: Transform.rotate(
                                                angle: -math.pi / 7,
                                                child: Image(
                                                  width: 220.w,
                                                  image: NetworkImage(provider
                                                      .allCategories[index]
                                                      .imageUrl),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lan.getTexts('popular_product'),
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () => RouterHelper.routerHelper
                              .routingToSpecificWidget(
                                  const AllProductScreen()),
                          child: Text(
                            lan.getTexts('view_all'),
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  //  ...provider.allProducts.map((data) {

                  ...provider.allProducts
                      .where((element) => element.isPopular)
                      .map((data) {
                    return GestureDetector(
                      onTap: () {
                        RouterHelper.routerHelper
                            .routingToSpecificWidgetWithoutPop(
                                DetailPage(product: data, forHome: true));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 16.0.w, right: 16.w, bottom: 10.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 20.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Hero(
                              child: Image(
                                image: NetworkImage(data.imageUrl),
                                width: 100.w,
                                height: 60.h,
                              ),
                              tag: data.id,
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        .4.w,
                                    child: Text(
                                      data.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(data.brand,
                                      style: TextStyle(
                                          color: Colors.black26,
                                          height: 1.5.h)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Text(
                                "\$${data.price.toInt()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: kPrimaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
