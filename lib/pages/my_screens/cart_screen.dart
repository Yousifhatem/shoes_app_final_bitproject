import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/pages/my_screens/checkout_screen.dart';
import 'package:shop_app_final/pages/my_screens/home_page.dart';

import '../../components/rounded_icon_btn.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'bottom_navigaion_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key, this.productId}) : super(key: key);
  String productId;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${Provider
                  .of<AppProvider>(context, listen: false)
                  .cartProducts
                  .length} items",
              style: Theme
                  .of(context)
                  .textTheme
                  .caption,
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            RouterHelper.routerHelper
                .routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.grey[250],
      body: Stack(
        children: [
          Consumer<AppProvider>(
            builder: (context, provider, x) {
              return ListView.builder(
                itemCount: provider.cartProducts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Dismissible(
                      key: Key(provider.cartProducts[index].id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        provider.deleteCartProduct(provider.cartProducts[index]
                            .id);
                      },
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: const [
                            Spacer(),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      child: Card(
                        elevation: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                                width: 85.w,
                                height: 85.h,
                                decoration: BoxDecoration(
                                  color: provider.getBGClrWithOpacity(
                                      provider.cartProducts[index].color),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.network(
                                  provider.cartProducts[index].imageUrl,
                                  width: 80.w,
                                  height: 80.h,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.cartProducts[index].name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    provider.cartProducts[index].description,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [

                                      RoundedIconBtn(
                                        icon: Icons.remove,
                                        press: () {
                                          if (provider.cartProducts[index]
                                              .numOfCount == null) {
                                            setState(() {
                                              provider.cartProducts[index]
                                                  .numOfCount = 1;
                                            });
                                          }
                                          setState(() {
                                            if(provider.cartProducts[index].numOfCount>1) {
                                              provider.cartProducts[index]
                                                .numOfCount =
                                                provider.cartProducts[index]
                                                    .numOfCount - 1;
                                            }
                                          });
                                          totalPrice -=
                                              provider.cartProducts[index]
                                                  .price;
                                        },
                                      ),

                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          provider.cartProducts[index]
                                              .numOfCount != null ? provider
                                              .cartProducts[index].numOfCount
                                              .toString() : '${
                                              provider.cartProducts[index]
                                                  .numOfCount = 1}',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),

                                      RoundedIconBtn(
                                        icon: Icons.add,
                                        showShadow: true,
                                        press: () {
                                          if (provider.cartProducts[index]
                                              .numOfCount == null) {
                                            setState(() {
                                              provider.cartProducts[index]
                                                  .numOfCount = 1;
                                            });
                                          }
                                          setState(() {
                                            provider.cartProducts[index]
                                                .numOfCount =
                                                provider.cartProducts[index]
                                                    .numOfCount + 1;
                                          });
                                          totalPrice += provider.cartProducts[index].price;
                                        },
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text('\$' +
                                        (provider.cartProducts[index].price *
                                            provider.cartProducts[index]
                                                .numOfCount).toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 180.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.all(10),
                  //       height: 40.h,
                  //       width: 40.w,
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //         color: const Color(0xFFF5F6F9),
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: const Icon(
                  //         Icons.receipt,
                  //         color: kPrimaryColor,
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //     GestureDetector(
                  //       onTap: () {
                  //         print('Add voucher code is active');
                  //       },
                  //       child: const Text(
                  //         "Add voucher code",
                  //         style: TextStyle(color: Colors.grey),
                  //       ),
                  //     ),
                  //     SizedBox(width: 10.w),
                  //     const Icon(
                  //       Icons.arrow_forward_ios,
                  //       size: 12,
                  //       color: kTextColor,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Total :\n",
                          style: const TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: '\$' + totalPrice.toString(),
                              style:
                              const TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const CheckOutScreen());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          //margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          //  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                          child: const Text(
                            'Check Out',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildOutlineButton({IconData icon, Function press}) {
    return  Container(
      width: 25,
        height: 25,
        margin: const EdgeInsets.only(left: 10),
        //color: Colors.black,
        alignment: Alignment.center,
        child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            ),
          ),
          onPressed: press,
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),

    );
  }
}
