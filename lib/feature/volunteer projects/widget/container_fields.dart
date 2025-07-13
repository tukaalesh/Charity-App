import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/botton_fields.dart';
import 'package:flutter/material.dart';

class ContainerFields extends StatelessWidget {
  const ContainerFields({
    super.key,
    required this.onPressed,
    required this.text,
    required this.buttomtext,
    required this.image,
  });

  final void Function()? onPressed;
  final String text;
  final String buttomtext;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey[850]
            : const Color.fromARGB(255, 250, 251, 252),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 19),
          Image(
            image: image,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 19),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 19),
          BottonFields(
            text: "فرص التطوع",
            onPressed: onPressed,
          ),
         
          const SizedBox(height: 19),
        ],
      ),
    );
  }
}
