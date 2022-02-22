import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_final/controller/controller/provider/language_provider.dart';
import 'package:shop_app_final/pages/my_screens/splash/splash_screen.dart';

import 'controller/controller/provider/app_provider.dart';
import 'controller/controller/router_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(ChangeNotifierProvider<AppProvider>(
  //     create: (context) => AppProvider(),
  //     child: MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       navigatorKey: RouterHelper.routerHelper.routerKey,
  //       home: SplashScreen(),
  //     )));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppProvider>(create: (context) {
        return AppProvider();
      }),
      ChangeNotifierProvider<LanguageProvider>(create: (context) {
        return LanguageProvider();
      }),
    ],
    child: ScreenUtilInit(
      designSize: const Size(411, 820),
      builder: () => MaterialApp(
        navigatorKey: RouterHelper.routerHelper.routerKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        // routes: RouterClass.routerClass.map,
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme,
      ),
      home: SplashScreen(),
    );
  }
}
