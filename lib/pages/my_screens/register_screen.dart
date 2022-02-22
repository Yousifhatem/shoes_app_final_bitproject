import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/model/fir_user.dart';
import 'package:shop_app_final/pages/my_screens/profile_screen.dart';
import 'package:shop_app_final/widgets/custom_button.dart';
import 'package:shop_app_final/widgets/custom_textfield.dart';

import '../../constants.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {

  bool forEdit;
  RegisterScreen({this.forEdit});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            forEdit? RouterHelper.routerHelper
                .routingToSpecificWidgetWithoutPop(ProfilePage())
            : RouterHelper.routerHelper
                .routingToSpecificWidgetWithoutPop(LoginScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<AppProvider>(
          builder: (context, provider, x) {
            return Form(
              key: provider.registerFormKey,
              child: Container(
                margin:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: [
                    forEdit? const Text('Edit Account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),) :
                    const Text("Register Account",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Visibility(
                      visible: forEdit == false,
                      child: const Text(
                        "Complete your details or continue \nwith social media",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        provider.selectSource(context);
                      },
                      child: provider.file == null
                          ? provider.imageUrlUser == null
                              ? const CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage(
                            'assets/images/empty_avatar.png'),
                      )
                              : CircleAvatar(
                                  radius: 90,
                                  backgroundImage:
                                      NetworkImage(provider.imageUrlUser),
                                )
                          : CircleAvatar(
                              radius: 90,
                              backgroundImage: FileImage(provider.file),
                            ),
                    ),
                    SizedBox(height: 10.h,),
                    CustomTextField(
                      label: 'Enter Your Name',
                      controller: provider.userNameController,
                      validationFun: provider.nullValidator,
                    ),
                    CustomTextField(
                      label: 'Enter Your Address',
                      controller: provider.userAddressController,
                      validationFun: provider.nullValidator,
                    ),
                    CustomTextField(
                      label: 'Enter Your Phone',
                      controller: provider.userPhoneController,
                      textInputType: TextInputType.number,
                      validationFun: provider.nullValidator,
                    ),
                    CustomTextField(
                      label: 'Enter Your Email',
                      controller: provider.userEmailController,
                      textInputType: TextInputType.emailAddress,
                      validationFun: provider.emailValidation,
                    ),
                    Visibility(
                      visible: forEdit == false,
                      child: CustomTextField(
                        label: 'Enter Your Password',
                        controller: provider.userPasswordController,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        validationFun: provider.passworsdValidator,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Builder(builder: (context) {
                      return forEdit?
                      CustomButton(
                        title: 'Update',
                        function: () {
                          provider.editUser(provider.loggedFireUser.id);
                          RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(ProfilePage(forEdit: true,));
                        },
                      )

                          :CustomButton(
                        title: 'Register',
                        function: () {
                          FireUser user = FireUser(
                              name: provider.userNameController.text,
                              address: provider.userAddressController.text,
                              phone: provider.userPhoneController.text,
                              email: provider.userEmailController.text,
                              password: provider.userPasswordController.text);
                          provider.register(user, context);
                        },
                      );
                    }),
                    SizedBox(height: 10.h),
                    Visibility(
                      visible: forEdit == false,
                      child: TextButton(
                        onPressed: () {
                          RouterHelper.routerHelper
                              .routingToSpecificWidgetWithoutPop(LoginScreen());
                        },
                        child: const Text(
                          'Have already account?',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Visibility(
                      visible: forEdit == false,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 80.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.all(10),
                                child: Image.asset('assets/images/google.png'),
                                height: 40.h,
                                width: 40.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              onTap: () {
                                print('register with gmail');
                              },
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.all(10),
                                child: Image.asset('assets/images/facebook.png'),
                                height: 40.h,
                                width: 40.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              onTap: () {
                                print('register with facbook');
                              },
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.all(10),
                                child: Image.asset('assets/images/twitter.png'),
                                height: 40.h,
                                width: 40.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF5F6F9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              onTap: () {
                                print('register with twitter');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Visibility(
                      visible: forEdit == false,
                      child: Text(
                        'By continuing your confirm that you agree \nwith our Term and Condition',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
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
