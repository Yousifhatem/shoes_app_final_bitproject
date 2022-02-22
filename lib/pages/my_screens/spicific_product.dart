import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/model/product.dart';
import 'package:shop_app_final/pages/my_screens/detail_page.dart';
import 'package:shop_app_final/widgets/product_widget.dart';

import 'bottom_navigaion_screen.dart';
import 'home_page.dart';

class SpisificProductScreen extends StatelessWidget {
  const SpisificProductScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
             RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
             Provider.of<AppProvider>(context, listen: false).spacificProducts = null;
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, x){
          return provider.spacificProducts == null?
              const Center(child: CircularProgressIndicator(),)
              :provider.spacificProducts.isEmpty? const Center(child: Text('No Found Products!'),)
              :GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (contex, index){
                  Product product = provider.spacificProducts[index];
                  return ProductCard2(product: product,onTap:(){
                    RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(
                        DetailPage(product: product, forHome: false, forFav: false, forSpisific: true,));
                  },);
                  },
                itemCount: provider.spacificProducts.length,
              );
        },
      ),
    );
  }
}
