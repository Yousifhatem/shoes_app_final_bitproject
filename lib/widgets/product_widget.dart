// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../constants.dart';
// import '../controller/controller/router_helper.dart';
// import '../model/product.dart';
// import '../pages/my_screens/detail_page.dart';
// import '../size_config.dart';
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import '../constants.dart';
import '../controller/controller/router_helper.dart';
import '../model/product.dart';
import '../pages/my_screens/detail_page.dart';

class ProductCard2 extends StatelessWidget {
  ProductCard2({
    Key key,
    this.product,
    this.onTap,
  }) : super(key: key);

  final Product product;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
     // padding: const EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        width: double.infinity.w,
        // color: Colors.red,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.w,
                height: 150.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF979797).withOpacity(0.1),
                ),
                child: Hero(
                  tag: product.id,
                  child: Image.network(product.imageUrl),
                ),
              ),

              SizedBox(
                height: 10.h,
              ),
              Text(
                product.name,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              //SizedBox(height: 3.h,),
              Consumer<AppProvider>(
                builder: (context, provider, x) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price}\$',
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      //const Spacer(),
                      InkWell(
                        onTap: () {
                           product.isFavorite = !product.isFavorite;

                          if (product.isFavorite) {
                            provider.addFavoiriteProduct(product);
                          } else {
                            provider.deleteFavoiriteProduct(product.id);
                          }
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 30,
                          color: product.isFavorite
                              ? const Color(0xFFFF4848)
                              : const Color(0xFFDBDEE4),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Stack(
// children: [
// Consumer<AppProvider>(
// builder: (context, provider, x){
// return Column(
// children: [
// Container(
// padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
// height: 150.h,
// width: 150.w,
// decoration: BoxDecoration(
// color: provider.getBGClrWithOpacity(product.color),
// borderRadius: BorderRadius.circular(18),
// border: Border.all(
// color: provider.getBGClrWithOpacityForBorder(product.color),
// width: 2,
// ),
// ),
// child: Hero(
// child: Image.network(product.imageUrl),
// tag: product.id,
// ),
// ),
// SizedBox(height: 5.h,),
// Center(
// child: Text(
// product.name,
// textAlign: TextAlign.center,
// style: const TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// SizedBox(height: 10.h,),
// Row(
// children: [
// Text(product.price.toString(), style: const TextStyle(color: kPrimaryColor),),
// const Spacer(),
// IconButton(
// onPressed: (){},
// icon: const Icon(Icons.favorite, color: Colors.red,)
// ),
//
//
// ],
// ),
//
// ],
// );
// },
// ),
// ],
// ),

//   @override
//   Widget build(BuildContext context) {
//   //  var lan = Provider.of<LanguageProvider>(context,listen: true);
//
//     return InkWell(
//         onTap: ()=> RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(DetailPage(product: product, forHome: false)),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         elevation: 4, // الارتفاع
//         margin: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   // لجعل الصورة تنعرض داخل المكان بشكل ملائم وبحجم مناسب
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                   ),
//                   child: Hero(
//                     tag: product.id, // يجب ان يكون ال tag فريد
//                     child: InteractiveViewer(
//                       child: FadeInImage(
//                         width: double.infinity,
//                         height: 200.h,
//                         placeholder: const AssetImage('assets/images/apple-pay.png'),
//                         image: NetworkImage(product.imageUrl),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20.h,
//                   right: 10.w,
//                   child: Container(
//                     color: Colors.black54,
//                     padding:
//                     EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
//                     width: 300.w,
//                     child: Text(
//                       product.name,
//                       style: const TextStyle(
//                         fontSize: 26,
//                         color: Colors.white,
//                       ),
//                       softWrap: true,
//                       overflow: TextOverflow.fade,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Row(
//                     children: [
//                       Text(product.price.toString(), style: const TextStyle(color: kPrimaryColor),),
//                       const Spacer(),
//                       Icon(Icons.attach_money,color: Theme.of(context).splashColor,),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// ****************************************
// news

// Container(
// margin: const EdgeInsets.all(10),
// padding: EdgeInsets.only(bottom: 10.h),
// child: GestureDetector(
// onTap: ()=>RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(DetailPage(product: product, forHome: false)),
// child: Container(
// decoration: BoxDecoration(
// color: provider.getBGClrWithOpacity(provider.allProducts[index].color),
// borderRadius: BorderRadius.circular(18),
// border: Border.all(
// color: provider.getBGClrWithOpacityForBorder(provider.allProducts[index].color),
// width: 2,
// ),
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SizedBox(
// height: 100.h,
// width: 120.w,
// child: Hero(
// child: Image.network(product.imageUrl,),
// tag: product.id,
// ),
// ),
// SizedBox(
// height: 20.h,
// child: Center(
// child: Text(
// product.name,
// textAlign: TextAlign.center,
// style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
// ),
// ),
// ),
// SizedBox(height: 5.h,),
// Consumer<AppProvider>(
// builder: (context, provider, x){
// return IconButton(
// onPressed: (){
// log('message');
//
// product.isFavorite=!product.isFavorite;
// if(product.isFavorite) {
// provider.addFavoiriteProduct(product);
// }else{
// provider.deleteFavoiriteProduct(product.id);
// }
//
// },
// icon: Icon(Icons.favorite, color: product.isFavorite? Colors.red: Colors.grey,),
// );
// },
// ),
// Expanded(child: Text('\$'+product.price.toString(), style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,))
// ],
// ),
// ),
// ),
// );



//-------------------------------------
// spisific Psc

// Container(
// margin: const EdgeInsets.all(10),
// padding: EdgeInsets.only(bottom: 10.h),
// child: GestureDetector(
// onTap: ()=>RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(DetailPage(product: product, forHome: false)),
// child: Container(
// decoration: BoxDecoration(
// color: provider.getBGClrWithOpacity(provider.spacificProducts[index].color),
// borderRadius: BorderRadius.circular(18),
// border: Border.all(
// color: provider.getBGClrWithOpacityForBorder(provider.spacificProducts[index].color),
// width: 2.w,
// ),
// ),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SizedBox(
// height: 100.h,
// width: 120.w,
// child: Hero(
// child: Image.network(product.imageUrl),
// tag: product.id,
// ),
// ),
// SizedBox(
// height: 20.h,
// child: Center(
// child: Text(
// product.name,
// textAlign: TextAlign.center,
// style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
// ),
// ),
// ),
// SizedBox(height: 5.h,),
// Expanded(child: Text('\$'+product.price.toString(), style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,))
// ],
// ),
// ),
// ),
// )