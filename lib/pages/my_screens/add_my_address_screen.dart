import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/pages/my_screens/address_screen.dart';

import '../../constants.dart';
import '../../controller/controller/provider/app_provider.dart';
import '../../controller/controller/router_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'bottom_navigaion_screen.dart';
import 'home_page.dart';

class AddMyAddressScreen extends StatelessWidget {

  bool isForEdit;
  String addressId;

  AddMyAddressScreen({Key key, this.addressId, this.isForEdit = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            isForEdit? RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddressScreen())
            : RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
          },
        ),
        backgroundColor: Colors.white,
        // title: const Text('Add My Address Screen', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Consumer<AppProvider>(
          builder: (context, provider, x) {
            return Form(
              key: provider.addAddressFormKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: [
                     Text(isForEdit? 'Edit Address' : 'Add Address',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      label: 'Enter Address Name',
                      controller: provider.addressNameController,
                      textInputType: TextInputType.text,
                      validationFun: provider.nullValidator,
                    ),
                    CustomTextField(
                      label: 'Enter Street Name',
                      controller: provider.streetController,
                      textInputType: TextInputType.text,
                      validationFun: provider.nullValidator,
                    ),
                    CustomTextField(
                      label: 'Enter City Name',
                      controller: provider.cityController,
                      textInputType: TextInputType.text,
                      validationFun: provider.nullValidator,
                    ),
                    CustomTextField(
                      label: 'Enter Zip Code',
                      controller: provider.zipCodeController,
                      textInputType: TextInputType.number,
                      validationFun: provider.nullValidator,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    isForEdit ? CustomButton(
                      title: 'Edit Address',
                      function: () =>
                          provider.editAddress(addressId),
                    )
                        : CustomButton(
                      title: 'Add Address',
                      function: () {
                         provider.addAddress(context);
                         showDialog(
                             context: context,
                             builder: (context) {
                               return AlertDialog(
                                 content: const Text(
                                   'Successfully added!',
                                   textAlign: TextAlign.center,
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
                                             RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddressScreen());                                           },
                                           child: Container(
                                             width: double.infinity.w,
                                             alignment: Alignment.center,
                                             height: 50.h,
                                             child: const Text(
                                               'Show My Address',
                                               style: TextStyle(
                                                   color: Colors.white,
                                                   fontSize: 15,
                                                   fontWeight: FontWeight.bold),
                                             ),
                                             decoration: BoxDecoration(
                                               color: kPrimaryColor,
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
