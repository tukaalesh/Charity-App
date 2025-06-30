import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ButtonOutlined extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color borderColor;
  final Color textColor;

  const ButtonOutlined({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
        width: size.width / 4.3,
        height: size.height * 0.05,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: colorScheme.surface,
            side: BorderSide(color: borderColor, width: 1.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            textStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
