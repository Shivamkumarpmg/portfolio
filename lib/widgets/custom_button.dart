import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text; 
  final Color textColor;
  final Color? buttonColor;
  final VoidCallback onTap;
  final double? fontSize;
  final bool? isLoading;

  CustomButton({
    super.key,
    required this.text,
    this.textColor = Colors.white, // Default text color
    required this.onTap,
    this.buttonColor, // Default button color
    this.fontSize = 18,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: ColorConst.themeColor,
              strokeWidth: 4,
            ),
          ),
        )
        : ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                buttonColor ?? ColorConst.themeColor, // Apply background color
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontFamily: AppFonts.themeFont,
            ),
          ),
        );
  }
}
