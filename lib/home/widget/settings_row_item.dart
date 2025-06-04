import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsRowItem extends StatelessWidget {
  SettingsRowItem(
      {super.key,
      required this.text,
      required this.icon,
      required this.color,
      this.onTap});
  final String text;
  final Icon icon;
  final Color color;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Column(
          children: [
            const SizedBox(
              height: 28,
            ),
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text,
                    style: TextStyle(fontSize: 22, color: color),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
