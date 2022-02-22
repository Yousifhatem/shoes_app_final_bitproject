import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/constants.dart';
import 'package:shop_app_final/controller/controller/provider/app_provider.dart';
import 'package:shop_app_final/pages/my_screens/register_screen.dart';

import '../../controller/controller/router_helper.dart';
import 'bottom_navigaion_screen.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({Key key, this.forEdit}) : super(key: key);
  bool forEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor.withOpacity(0.7),
        //const Color(0xff555555),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            RouterHelper.routerHelper
                .routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
          },
        ),
        actions: [
          Consumer<AppProvider>(
            builder: (context, provider, x){
              return IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  provider.goToEditUser(provider.loggedFireUser);
                  RouterHelper.routerHelper
                      .routingToSpecificWidgetWithoutPop(RegisterScreen(forEdit: true,));
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Consumer<AppProvider>(
            builder: (context, provider, x){
              return ListView(
                children: [
                  SizedBox(height: 400.h,),
                  Container(
                    width: double.infinity.w,
                    height: 450,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                   // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Personal Information',
                          style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                        SizedBox(height: 30.h,),
                        Row(
                          children: [
                            const Text('Name:', style: TextStyle(color: Colors.grey),),
                            const Spacer(),
                            Text(provider.loggedFireUser.name,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            const Text('Email:', style: TextStyle(color: Colors.grey),),
                            const Spacer(),
                            Text(provider.loggedFireUser.email,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            const Text('Address:', style: TextStyle(color: Colors.grey),),
                            const Spacer(),
                            Text(provider.loggedFireUser.address,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            const Text('Phone:', style: TextStyle(color: Colors.grey),),
                            const Spacer(),
                            Text(provider.loggedFireUser.phone,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          CustomPaint(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Consumer<AppProvider>(
            builder: (context, provider, x) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 35,
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  provider.loggedFireUser.imageUser == null
                      ? Container(
                          padding: const EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/empty_avatar.png'),
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  provider.loggedFireUser.imageUser),
                            ),
                          ),
                        ),
                  SizedBox(height: 10.h,),
                  Text(provider.loggedFireUser.email, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ],
              );
            },
          ),
          // forEdit?
          // Consumer<AppProvider>(
          //   builder: (context, provider, x) {
          //     return Padding(
          //       padding: const EdgeInsets.only(bottom: 270, left: 184),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.black54,
          //         child: IconButton(
          //           icon: const Icon(
          //             Icons.edit,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {
          //             provider.selectSource(context);
          //           },
          //         ),
          //       ),
          //     );
          //   },
          // ): Container(),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = kPrimaryColor.withOpacity(0.7);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// import 'package:flutter/material.dart';
//
// import '../../controller/controller/router_helper.dart';
// import 'bottom_navigaion_screen.dart';
// import 'home_page.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black,),
//           onPressed: (){
//             RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(const BottmNavigationBar());
//           },
//         ),
//         backgroundColor: Colors.grey[250],
//         title: const Text('Profile Screen', style: TextStyle(color: Colors.black),),
//       ),
//     );
//   }
// }
