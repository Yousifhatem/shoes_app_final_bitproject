import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/core/const.dart';
import 'package:shop_app_final/model/product.dart';
import 'package:shop_app_final/pages/my_screens/al_products_screen.dart';
import 'package:shop_app_final/pages/my_screens/favorite_screen.dart';
import 'package:shop_app_final/pages/my_screens/spicific_product.dart';
import 'dart:math' as math;

import 'package:shop_app_final/widgets/app_clipper.dart';

import 'bottom_navigaion_screen.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  bool forHome;
  bool forFav;
  bool forSpisific;

  DetailPage(
      {this.product,
      this.forHome,
      this.forFav = false,
      this.forSpisific = false});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey _key = GlobalKey();

  double _valueHeightComponent = 0;
  bool _isOffstage = true;
  double _offsetHeight = 0;
  AppBar _appBar = AppBar();

  _getSizes() {
    if (_valueHeightComponent == 0) {
      final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
      final sizeRed = renderBoxRed.size;
      _valueHeightComponent = sizeRed.height;

      double heightAppBar = _appBar.preferredSize.height;
      //double paddingBottom = MediaQuery.of(context).padding.bottom;
      double paddingTop = MediaQuery.of(context).padding.top;

      double total = _valueHeightComponent +
          heightAppBar +
          //paddingBottom +
          paddingTop +
          100;

      if (total <= MediaQuery.of(context).size.height) {
        double _tempoffsetHeight = MediaQuery.of(context).size.height - total;

        setState(() {
          _isOffstage = false;
          _offsetHeight = _tempoffsetHeight;
        });
      } else {
        setState(() {
          _isOffstage = true;
          _offsetHeight = 0;
        });
      }
    }
  }

  _afterLayout(_) {
    _getSizes();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, x) {
        return Scaffold(
          backgroundColor: provider.getBGClr(widget.product.color),
          appBar: _appBar = AppBar(
            backgroundColor: provider.getBGClr(widget.product.color),
            elevation: 0,
            title: const Text("Categories"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (widget.forHome) {
                  RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(
                      const BottmNavigationBar());
                } else if (widget.forFav) {
                  RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(
                      const FavoriteProductScreen());
                } else if (widget.forSpisific) {
                  RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(
                      const SpisificProductScreen());
                } else {
                  RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(
                      const AllProductScreen());
                }
              },
            ),
          ),
          body: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Stack(
                children: [
                  ClipPath(
                    key: _key,
                    clipper: AppClipper(
                        cornerSize: 60,
                        diagonalHeight: 190.h,
                        roundedBottom: false), //50 180  (0, 250)
                    child: Container(
                      //Add this.
                      color: Colors.white,
                      padding:
                          EdgeInsets.only(top: 230.h, left: 16.w, right: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 300.w,
                            child: Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildRating(3),
                          SizedBox(height: 24.h),
                          const Text(
                            "DETAILS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            widget.product.description,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black38),
                          ),
                          SizedBox(height: 24.h),
                          const Text(
                            "COLOR OPTIONS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              _buildColorOption(AppColors.blueColor),
                              _buildColorOption(AppColors.greenColor),
                              _buildColorOption(AppColors.orangeColor),
                              _buildColorOption(AppColors.redColor),
                              _buildColorOption(AppColors.yellowColor),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Offstage(
                              offstage: _isOffstage,
                              child: Container(
                                height: _offsetHeight,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: Center(
                      child: Hero(
                        tag: widget.product.id,
                        child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              top: 30.h,
                            ),
                            constraints: BoxConstraints(
                                minHeight: 50.h, maxHeight: 170.h),
                            // alignment: Alignment.center,
                            child: Transform.rotate(
                              angle: -math.pi / 100,
                              child: Image(
                                width:
                                    MediaQuery.of(context).size.width * 0.75.w,
                                image: NetworkImage(widget.product.imageUrl),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ],
            ),
            child: _buildBottom(),
          ),
        );
      },
    );
  }

  Widget _buildBottom() {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 10,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "PRICE",
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Consumer<AppProvider>(
                builder: (context, provider, x) {
                  return Text(
                    "\$${widget.product.price.toInt()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: provider.getBGClr(widget.product.color),
                    ),
                  );
                },
              ),
            ],
          ),
          Consumer<AppProvider>(
            builder: (context, provider, x) {
              return GestureDetector(
                onTap: () {
                  provider.addProductToCartProduct(widget.product);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                            'Successfully added to cart!',
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100.w,
                                    height: 100.h,
                                    child: Image.asset(
                                      'assets/images/success.png',
                                      fit: BoxFit.cover,
                                      width: 100.w,
                                      height: 100.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      RouterHelper.routerHelper.popFunction();
                                    },
                                    child: Container(
                                      width: double.infinity.w,
                                      alignment: Alignment.center,
                                      height: 50.h,
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      decoration: BoxDecoration(
                                        color: provider
                                            .getBGClr(widget.product.color),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 50.w,
                  ),
                  decoration: BoxDecoration(
                    // color: AppColors.greenColor,
                    color: provider.getBGClr(widget.product.color),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: const Text(
                    "ADD CART",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return Container(
      width: 20.w,
      height: 20.h,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    );
  }

  Widget _buildRating(double rate) {
    return Row(
      children: [
        RatingBar(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
          onRatingUpdate: (rating) {
            setState(() {
              rate = rating;
            });
            print(rate);
          },
          ratingWidget: RatingWidget(
            full: const Icon(Icons.star, color: Colors.amber),
            empty: Icon(Icons.star, color: Colors.grey[200]),
            half: const Icon(Icons.star_half_outlined, color: Colors.amber),
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          "$rate Reviews".toString(),
          style: const TextStyle(color: Colors.black26),
        )
      ],
    );
  }
}
