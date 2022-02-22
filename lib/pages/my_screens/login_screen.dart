import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/controller/controller/router_helper.dart';
import 'package:shop_app_final/pages/my_screens/register_screen.dart';
import 'package:shop_app_final/widgets/custom_button.dart';
import 'package:shop_app_final/widgets/custom_textfield.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login Screen'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Consumer<AppProvider>(
          builder: (context, provider, x) {
            return Form(
              key: provider.loginFormKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: [
                    const Text("Welcome Back",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Text(
                      "Sign in with your email and password  \nor continue with social media",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      label: 'Enter Your Email',
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      validationFun: provider.emailValidation,
                    ),
                    CustomTextField(
                      label: 'Enter Your Password',
                      controller: passwordController,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      validationFun: provider.passworsdValidator,
                    ),
                     SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(
                      title: 'Login',
                      function: () {
                        provider.login(
                            emailController.text, passwordController.text, context);
                      },
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      width: MediaQuery.of(context).size.width.w,
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
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        SizedBox(width: 2.w,),
                        GestureDetector(
                          onTap: () {
                            RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(RegisterScreen(forEdit: false,));
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 16,
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
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
