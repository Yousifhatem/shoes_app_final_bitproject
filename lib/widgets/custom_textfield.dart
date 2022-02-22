import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  String label;
  TextEditingController controller;
  TextInputType textInputType;
  bool obscureText;
  Function validationFun;
  Function onChange;

  CustomTextField({Key key, this.label, this.textInputType = TextInputType.text, this.controller, this.obscureText = false, this.validationFun, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscureText,
        onChanged: onChange,
        validator: (value) => validationFun(value),
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )
        ),
      ),
    );
  }
}
