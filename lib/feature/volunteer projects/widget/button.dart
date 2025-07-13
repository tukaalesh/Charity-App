import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class VolunterButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? color;

  const VolunterButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return SizedBox(
      height: 44,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 1,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: colorScheme.surface,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
