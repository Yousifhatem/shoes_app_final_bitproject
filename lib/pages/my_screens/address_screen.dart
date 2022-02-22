import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/pages/my_screens/add_my_address_screen.dart';
import 'package:shop_app_final/widgets/address_widget.dart';

import 'bottom_navigaion_screen.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              RouterHelper.routerHelper.routingToSpecificWidget(const BottmNavigationBar());
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                RouterHelper.routerHelper.routingToSpecificWidget(AddMyAddressScreen(isForEdit: false,));
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Consumer<AppProvider>(
            builder: (ctx, provider, w) {
              return provider.allAdress.isEmpty
                  ? const Center(
                      child: Text(
                        'No Address Found!',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: provider.allAdress.length,
                      itemBuilder: (context, index) {
                        return AddressWidget(provider.allAdress[index]);
                      });
            },
          ),
        ));
  }
}
