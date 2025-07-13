import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class search extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final TextEditingController controller;

  const search({ super.key,required this.onSearchChanged,required this.controller});

  @override
  Widget build(BuildContext context) {
     final ColorScheme=context.colorScheme;
    final isDark = context.isDarkMode;
    return TextField(
      controller: controller,
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        hintText: 'ابحث عن مشروع محفوظ...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor:  isDark ? Colors.grey[850] : Colors.grey.shade300,
        // Colors.grey.shade300,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: ColorScheme.secondary, width: 2),
        ),
      ),
    );
  }
}
