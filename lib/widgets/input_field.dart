import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class InputField extends StatelessWidget {
  const InputField({Key key,  this.title,  this.hint, this.controller, this.widget}) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          ),
          Container(
            padding: EdgeInsets.only(left: 14.w),
            margin:  EdgeInsets.only(top: 8.h),
            width: MediaQuery.of(context).size.width,  // عرض الشاشة من كلاس جاهز انا عامله
            height: 52.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child:
            Row(
              children: [
                Expanded( // لياخذ مساحة العرض المتبقية
                    child: TextFormField(
                      controller: controller,
                      autofocus: false,
                      readOnly: widget != null? true : false,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      cursorColor: Colors.grey[700],
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).backgroundColor,
                            width: 0.w,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                          color: Theme.of(context).backgroundColor,
                          ),
                        ),

                      ),
                    ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
