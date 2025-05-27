import 'package:flutter/material.dart';

import '../constants/constants.dart';
@immutable
class AppTextField extends StatelessWidget {
  final Icon? prefixeIcon;
  final String title;
  final TextEditingController controller;
  TextInputAction? textInputAction;
  TextInputType?textInputType;
  TextCapitalization? textCapitalization;
  int? maxLength;
  final Widget? sufixeIcon;
  final bool?readOnly;
  int?maxLine;
  VoidCallback? onTap;
  bool showPassword;
  AppTextField(
      {super.key,
        this.prefixeIcon,
        required this.title,
        required this.controller,this.textInputAction = TextInputAction.next, this.textCapitalization, this.textInputType,this.maxLength,this.sufixeIcon,this.readOnly,this.maxLine,this.onTap, this.showPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLine??1,
      readOnly: readOnly??false,
      cursorColor: Colors.black,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,

      onTapOutside: (event){
        FocusScope.of(context).unfocus();
      },
      onTap: onTap,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      obscureText: showPassword,
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontFamily: AppFonts.themeFont),
      decoration: InputDecoration(
        suffixIcon: sufixeIcon,
        counterText: "",
        prefixIcon: prefixeIcon,
        hintText: title,
        filled: false,
        hintStyle: const TextStyle(
            color: ColorConst.greyFourth, fontSize: 16),
        fillColor: ColorConst.textboxBackgroundColor,

        // Default border color (white)
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConst.greyThree,width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),

        // Border when the field is enabled (white)
        enabledBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: ColorConst.greyThree, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),

        // Border when the field is focused (white)
        focusedBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: ColorConst.greyThree, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
