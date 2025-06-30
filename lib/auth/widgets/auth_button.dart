import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class Authbutton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color color;

  const Authbutton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 1,
      height: size.height * 0.075,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: colorScheme.surface),
        ),
      ),
    );
  }
}
