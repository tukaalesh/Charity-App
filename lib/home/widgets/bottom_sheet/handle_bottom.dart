import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class HandleBottom extends StatelessWidget {
  const HandleBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
          color:  isDark ? const Color(0xFFF3F4F6) : Colors.grey[400],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}