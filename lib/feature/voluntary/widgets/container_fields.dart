import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/voluntary/widgets/buttom.dart';
import 'package:flutter/material.dart';

class ContainerFields extends StatelessWidget {
  const ContainerFields({
    super.key,
    this.onTap,
    required this.text,
    required this.buttomtext,
    this.buttomonTap,
    required this.image,
  });

  final void Function()? onTap;
  final void Function()? buttomonTap;
  final String text;

  final String buttomtext;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.grey[850]
              : const Color.fromARGB(255, 239, 239, 239),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 19),
            Image(
              image: image,
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 19),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 19),
            Button(
              buttonText: "فرص التطوع",
              onPressed: () {},
              color: colorScheme.primary,
            ),
            const SizedBox(height: 19),
          ],
        ),
      ),
    );
  }
}
