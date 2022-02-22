import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/model/address.dart';
import 'package:shop_app_final/pages/my_screens/add_my_address_screen.dart';


class AddressWidget extends StatelessWidget {
  Address address;
  AddressWidget(this.address, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Container(
        width: double.infinity.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: Consumer<AppProvider>(
          builder: (ctx, provider, w){
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: (){
                      provider.deleteAddress(address.id);
                    },
                  ),
                ),
                SizedBox(width: 10.w,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(address.addressName ?? ""),
                     SizedBox(height: 10.h,),
                    Text(address.street ?? ""),
                     SizedBox(height: 10.h,),
                    Text(address.cityName ?? ""),
                     SizedBox(height: 10.h,),
                    Text(address.zipCode.toString() ?? ""),
                  ],
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange,),
                    onPressed: (){
                      provider.goToEditAdreess(address);
                      RouterHelper.routerHelper
                          .routingToSpecificWidgetWithoutPop(AddMyAddressScreen(isForEdit: true, addressId: address.id,));
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}