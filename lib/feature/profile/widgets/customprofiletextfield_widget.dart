import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomProfileTextField extends StatelessWidget {
  CustomProfileTextField({
    super.key,
    required this.controller,
    required this.validatorText,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.borderRadius = 15,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputType = TextInputType.text,
    // required this.initialValue,
    // required this.onSavedValue,
  });

  final TextEditingController controller;
  String validatorText;
  String labelText;
  String hintText;
  IconData prefixIcon;

  double borderRadius;
  int maxLines;
  int minLines;
  TextInputType textInputType;

  // String? initialValue;
  // String onSavedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
      child: TextFormField(
        controller: controller,
        // initialValue: initialValue,
        validator: (value) {
          if (value!.isEmpty || value == "" || value == " ") {
            return validatorText;
          }
        },
        // onSaved: (value){
        //   onSavedValue = value!;
        // },
        onTapOutside: (event) {
          ///Hide Keyboard
          FocusManager.instance.primaryFocus?.unfocus();
        },
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: textInputType,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            filled: false,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            prefixIcon: Icon(prefixIcon)),
      ),
    );
  }
}
