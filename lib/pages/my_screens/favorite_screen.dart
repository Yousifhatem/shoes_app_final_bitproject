import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/model/product.dart';
import 'package:shop_app_final/pages/my_screens/detail_page.dart';

import 'bottom_navigaion_screen.dart';
import 'home_page.dart';

class FavoriteProductScreen extends StatelessWidget {
  const FavoriteProductScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
           // Provider.of<AppProvider>(context, listen: false).spacificProducts = null;
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, x){
          return provider.FavoriteProducts == null?
          const Center(child: CircularProgressIndicator(),)
              :provider.FavoriteProducts.isEmpty? const Center(child: Text('No Found Products!'),)
              :GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (contex, index){
              Product product = provider.FavoriteProducts[index];
              return Container(
                margin: const EdgeInsets.all(10),
                padding: EdgeInsets.only(bottom: 10.h),
                child: GestureDetector(
                  onTap: ()=> RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(DetailPage(product: product, forHome: false, forFav: true,)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: provider.getBGClrWithOpacity(provider.FavoriteProducts[index].color),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: provider.getBGClrWithOpacityForBorder(provider.FavoriteProducts[index].color),
                        width: 2.w,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100.h,
                          width: 120.w,
                          child: Hero(
                            child: Image.network(product.imageUrl),
                            tag: product.id,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                          child: Center(
                            child: Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Expanded(child: Text('\$'+product.price.toString(), style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,))
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: provider.FavoriteProducts.length,
          );
        },
      ),
    );
  }
}
