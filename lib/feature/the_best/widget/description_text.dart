import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Text(
      "هنا ندوّن أسماء الذين زرعوا الخير، وسقوا الأمل وكتبوا بأفعالهم سطورًا من الرحمة في مختلف مجالات الخير والعطاء",
      style: TextStyle(fontSize: 16,
       color:  isDark ? Colors.grey[400] : Colors.black,),
      textAlign: TextAlign.right,
    );
  }
}
