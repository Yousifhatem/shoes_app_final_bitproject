import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {

  Function function;
  String title;
  CustomButton({Key key, this.function, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        alignment: Alignment.center,
        child: Text(title, style: const TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor
        ),
      ),
    );
  }
}
