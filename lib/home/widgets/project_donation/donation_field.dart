import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class DonationField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator; 

  const DonationField({
    super.key,
    required this.controller,
    this.validator, 
  });

  @override
  Widget build(BuildContext context) {
     final ColorScheme=context.colorScheme;
    final isDark = context.isDarkMode;
    return TextFormField( 
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      validator: validator,
      decoration: InputDecoration(
        hintText: "مبلغ التبرع",
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon:  Icon(Icons.attach_money, color: ColorScheme.secondary),
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
          borderSide: BorderSide(color: ColorScheme.secondary),
        ),
        filled: true,
        fillColor:  isDark ? Colors.grey[850] :  Colors.grey[100],
        //Colors.grey[100],
      ),
    );
  }
}
