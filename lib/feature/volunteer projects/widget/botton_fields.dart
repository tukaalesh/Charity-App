// ignore_for_file: must_be_immutable

import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class BottonFields extends StatelessWidget {
  BottonFields({super.key, this.onPressed, required this.text});

  void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 6),
          ),
          child: Text(
            text,
            style: TextStyle(color: colorScheme.primary, fontSize: 13),
          ),
        ),
      ),
    );
  }
}
