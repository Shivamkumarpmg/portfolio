import 'package:flutter/material.dart';

import '../constants/colors.dart';

void showCustomSnackBar(
    BuildContext context, {
      required String message,
      Color? backgroundColor,
      IconData? icon,
      bool isWarning = false,
      bool isError = false,
      Duration duration = const Duration(seconds: 3),
    }) {
  final snackBar = SnackBar(
    duration: duration,
    backgroundColor: Colors.transparent, // Transparent to allow custom card style
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    content: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:(isError ? Colors.red : Colors.green),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
