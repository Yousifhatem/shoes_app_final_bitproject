import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/widgets/custom_textfield.dart';

import '../../constants.dart';
import '../../widgets/input_field.dart';
import 'bottom_navigaion_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}
class _CheckOutScreenState extends State<CheckOutScreen> {
  String price = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('CheckOut Screen', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
           RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Consumer<AppProvider>(
          builder: (context, provider, x){
            return ListView(
              children: [
                SizedBox(
                  width: double.infinity.w,
                  height: 200.h,
                  child: Lottie.asset('assets/images/credit_card.json', fit: BoxFit.cover),
                ),
                SizedBox(height: 30.h,),
                CustomTextField(
                  label: 'Enter Price',
                  controller: provider.priceController,
                  textInputType: TextInputType.number,
                  validationFun: provider.nullValidator,
                  onChange: (price) {
                    setState(() {
                      this.price = price;
                    });
                  },
                ),
                CustomTextField(
                  label: 'Enter Number Card',
                  controller: provider.numberCardController,
                  textInputType: TextInputType.number,
                  obscureText: true,
                  validationFun: provider.nullValidator,
                ),
                SizedBox(height: 10.h,),
                InputField(
                  title: 'Select Address',
                  hint: provider.selectedAddress,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                        items: provider.allAdress
                            .map<DropdownMenuItem<String>>(
                                (value) =>
                                DropdownMenuItem<String>(
                                  value: value.addressName,
                                  child: Text(
                                    value.addressName,
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ))
                            .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(
                          height: 0,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            provider.selectedAddress = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Total Price ',
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '$price\$',
                            style: const TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                        child: GestureDetector(
                          onTap: (){
                            print('payment Now!');
                          },
                            child: Container(
                              width: double.infinity.w,
                              height: 60.h,
                              alignment: Alignment.center,
                              child: const Text('Payment Now!',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                        )
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  onChange(String price){
    setState(() {
      this.price = price;
    });
  }
}
