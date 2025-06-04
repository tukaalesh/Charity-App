import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final void Function()? onPressed1;
  final String textButton;
  final String textButton1;

  const CustomAlertDialog({
    super.key,
    required this.title,
    this.onPressed,
    this.onPressed1,
    required this.textButton,
    required this.textButton1,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: onPressed,
                child: Text(
                  textButton,
                  style: TextStyle(color: colorScheme.secondary),
                ),
              ),
              TextButton(
                onPressed: onPressed1,
                child: Text(
                  textButton1,
                  style: TextStyle(color: colorScheme.secondary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
