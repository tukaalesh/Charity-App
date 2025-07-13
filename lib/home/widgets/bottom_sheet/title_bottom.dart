import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class TitleBottom extends StatelessWidget {
  const TitleBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Text(
      "إضافة مبلغ تبرع",
      style: TextStyle(
        color:  isDark ? const Color(0xFFF3F4F6) : Colors.black,
        fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}