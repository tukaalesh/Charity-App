import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class BottonMonthlyDonation extends StatelessWidget {
  BottonMonthlyDonation({super.key, this.onPressed, required this.text});

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
            side: BorderSide(color: colorScheme.secondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          ),
          child: Text(
            text,
            style: TextStyle(color: colorScheme.secondary, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
