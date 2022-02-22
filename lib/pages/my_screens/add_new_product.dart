import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/pages/my_screens/home_page.dart';
import 'package:shop_app_final/widgets/custom_button.dart';
import 'package:shop_app_final/widgets/custom_textfield.dart';
import 'package:shop_app_final/widgets/input_field.dart';
import 'dart:math' as math;

import '../../constants.dart';
import 'bottom_navigaion_screen.dart';

class AddNewProduct extends StatefulWidget {
  bool isForEdit;
  String categoryId ;


  AddNewProduct({Key key, this.isForEdit = false, this.categoryId})
      : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProduct();
}

class _AddNewProduct extends State<AddNewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        excludeHeaderSemantics: false,
        title: const Text('Add New Product Screen'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const BottmNavigationBar()),
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, x) {
          return Container(
            margin: EdgeInsets.only(top: 30.h),
            child: SingleChildScrollView(
              child: Column(
                //  crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Add Product",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 300.h,
                    child: provider.file == null
                        ? provider.productImageUrl == null
                            ? Container(
                                width: 230.w,
                                margin: EdgeInsets.only(right: 16.w),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 25.0.h),
                                      child: provider.buildAddImageContainer(
                                          index: 0,
                                          width: 230.w,
                                          function: () {
                                            provider.selectSource(context);
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                width: 230.w,
                                margin: EdgeInsets.only(right: 16.w),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 25.0.h),
                                      child: provider.buildAddImageContainer(
                                          index: 0,
                                          width: 230.w,
                                          function: () {
                                            provider.selectSource(context);
                                          }),
                                    ),
                                    Positioned(
                                      bottom: 130.h,
                                      right: 10.w,
                                      child: Transform.rotate(
                                        angle: -math.pi / 7,
                                        child: Image(
                                          width: 220.w,
                                          image:
                                              NetworkImage(provider.productImageUrl),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                        : Container(
                            width: 230.w,
                            margin: EdgeInsets.only(right: 16.w),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 25.0.h),
                                  child: provider.buildAddImageContainer(
                                      index: 0,
                                      width: 230.w,
                                      function: () {
                                        provider.selectSource(context);
                                      }),
                                ),
                                Positioned(
                                  bottom: 130.h,
                                  right: 10.w,
                                  child: Transform.rotate(
                                    angle: -math.pi / 7,
                                    child: Image(
                                      width: 220.w,
                                      image: FileImage(provider.file),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Form(
                    key: provider.addProductFormKey,
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: provider.productNameController,
                            label: 'Name',
                            validationFun: provider.nullAddProductValidator,
                          ),
                          CustomTextField(
                            controller: provider.productDescriptionController,
                            label: 'Description',
                            validationFun: provider.nullAddProductValidator,
                          ),
                          CustomTextField(
                            controller: provider.productPriceController,
                            label: 'Price',
                            textInputType: TextInputType.number,
                            validationFun: provider.nullAddProductValidator,
                          ),
                          InputField(
                            title: 'Select Brand',
                            hint: provider.selectedBrands,
                            widget: Row(
                              children: [
                                DropdownButton(
                                  dropdownColor: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  items: provider.brands
                                      .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                                value: value.toString(),
                                                child: Text(
                                                  value,
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
                                      provider.selectedBrands = newValue;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                           CheckboxListTile(
                             title: const Text('Is Popular'),
                              value: provider.isPopular,
                              onChanged: (val){
                                setState(() {
                                  provider.isPopular = val;
                                });
                              },
                          ),
                          SizedBox(height: 10.h,),
                          provider.colorPalette(),
                          SizedBox(
                            height: 20.h,
                          ),
                          widget.isForEdit
                              ? CustomButton(
                                  title: 'Edit Product',
                                  function: () =>
                                      provider.editProduct(widget.categoryId),
                                )
                              : CustomButton(
                                  title: 'Add Product',
                                  function: () => provider.addProduct(context,widget.categoryId),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
