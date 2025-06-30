import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ZakahHeader extends StatelessWidget {
  const ZakahHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Column(
      children: [
        Text(
          "الزكاة",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "تتيح هذه الخدمة للمستخدم بإمكانية دفع الزكاة بأنواعها ودفعها بطرق سهلة وسريعة للمستحقين",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
