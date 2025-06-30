import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class DonationField extends StatelessWidget {
  final TextEditingController controller;

  const DonationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorSheme = context.colorScheme;

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: "مبلغ التبرع",
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: const Icon(Icons.attach_money, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorSheme.secondary),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
