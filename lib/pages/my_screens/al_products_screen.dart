
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/model/product.dart';
import 'package:shop_app_final/pages/my_screens/detail_page.dart';

import '../../components/product_card.dart';
import '../../widgets/product_widget.dart';
import 'bottom_navigaion_screen.dart';
import 'home_page.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () => RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const BottmNavigationBar()),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, x){
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
                childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index){
              Product product = provider.allProducts[index];
              return ProductCard2(product: product,onTap:(){
                RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(
                    DetailPage(product: product, forHome: false, forFav: false, forSpisific: false,));
              },);
            },
            itemCount: provider.allProducts.length,
          );
        },
      ),
    );
  }
}




















// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
// import 'package:shop_app_final/controller/controller/router_helper.dart';
// import 'package:shop_app_final/model/product.dart';
// import 'package:shop_app_final/pages/my_screens/detail_page.dart';
// import 'package:shop_app_final/widgets/product_widget.dart';
//
// import 'home_page.dart';
//
// class AllProductScreen extends StatelessWidget {
//   const AllProductScreen({Key key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: Colors.black,),
//         onPressed: () => RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(HomePage()),
//       ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//       ),
//       body: Consumer<AppProvider>(
//         builder: (context, provider, x){
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//             padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//              // color: Colors.red,
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 4,
//                 crossAxisSpacing: 4,
//               ),
//               itemBuilder: (contex, index){
//                 Product product = provider.allProducts[index];
//                 return ProductCard(product: product, index: index,);
//
//
//
//                 // return Container(
//                 //   margin: const EdgeInsets.all(10),
//                 //   padding: EdgeInsets.only(bottom: 10.h),
//                 //   child: GestureDetector(
//                 //     onTap: ()=>RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(DetailPage(product: product, forHome: false)),
//                 //     child: Container(
//                 //       decoration: BoxDecoration(
//                 //         color: provider.getBGClrWithOpacity(provider.allProducts[index].color),
//                 //         borderRadius: BorderRadius.circular(18),
//                 //         border: Border.all(
//                 //           color: provider.getBGClrWithOpacityForBorder(provider.allProducts[index].color),
//                 //           width: 2,
//                 //         ),
//                 //       ),
//                 //       child: Column(
//                 //         mainAxisAlignment: MainAxisAlignment.center,
//                 //         children: [
//                 //           SizedBox(
//                 //             height: 100.h,
//                 //             width: 120.w,
//                 //             child: Hero(
//                 //                 child: Image.network(product.imageUrl),
//                 //               tag: product.id,
//                 //             ),
//                 //           ),
//                 //           SizedBox(
//                 //             height: 20.h,
//                 //             child: Center(
//                 //               child: Text(
//                 //                 product.name,
//                 //                 textAlign: TextAlign.center,
//                 //                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
//                 //               ),
//                 //             ),
//                 //           ),
//                 //           SizedBox(height: 5.h,),
//                 //           Expanded(child: Text('\$'+product.price.toString(), style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,))
//                 //         ],
//                 //       ),
//                 //     ),
//                 //   ),
//                 // );
//               },
//               itemCount: provider.allProducts.length,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

