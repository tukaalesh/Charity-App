import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ZakahHeader extends StatelessWidget {
  const ZakahHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme=context.colorScheme;
    final isDark = context.isDarkMode;
    return Column(
      children: [
        Text(
          "الزكاة",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorScheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "تتيح هذه الخدمة للمستخدم بإمكانية دفع الزكاة بأنواعها ودفعها بطرق سهلة وسريعة للمستحقين",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, 
          color:  isDark ? Colors.grey[400] : Colors.black,),
        ),
      ],
    );
  }
}