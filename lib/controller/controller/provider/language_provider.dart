import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
LanguageProvider(){
  getLan();
}
bool isEn = true;

  Map<String, Object> textsAr = {
    'brands':'الماركات',
    'popular_product':'المنتجات الشائعة',
    'view_all': 'عرض المزيد',
    'my_profile':'حسابي',
    'my_orders':'طلباتي',
    'shopping_cart':'سلة المشتريات',
    'favorite':'المفضلة',
    'my_address':'عنواني',
    'change_language':'تغيير اللغة',
    'english':'English',
    'arabic':'العربية',
    'logout':'تسجيل الخروج',
    'no_product_found!':'لا يوجد منتجات !',
    'add_category': 'إضافة ماركة',
    '':'',
    '':'',
    '':'',

  };
  Map<String, Object> textsEn = {
    'brands':'Brands',
    'popular_product':'Popular Products',
    'view_all': 'View All',
    'my_profile':'My Profile',
    'my_orders':'My Orders',
    'shopping_cart':'Shopping Cart',
    'favorite':'Favorites',
    'my_address':'My Address',
    'change_language':'Change Language',
    'arabic':'العربية',
    'english':'English',
    'logout':'Log Out',
    'no_product_found!':'No Products Found!',
    'add_brands': 'Add Brands',



  };

  changeLan(bool lan) async{
    isEn = lan;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isEn", isEn);
  }

  getLan() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEn = prefs.getBool("isEn")?? true;
    notifyListeners();
  }

  Object getTexts(String txt) {
    if (isEn == true) return textsEn[txt];
    return textsAr[txt];
  }
}
