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
                style: TextButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  textButton,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: onPressed1,
                style: TextButton.styleFrom(
                  // backgroundColor: Colors.grey[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                ),
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


class CusAlertDialog extends StatelessWidget {
  final String title;
  final void Function()? onConfirm; // زر التأكيد
  final void Function()? onCancel;  // زر الإلغاء
  final String confirmText;
  final String cancelText;

  const CusAlertDialog({
    super.key,
    required this.title,
    this.onConfirm,
    this.onCancel,
    required this.confirmText,
    required this.cancelText,
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
              // زر الإلغاء - باللون العادي
              TextButton(
                onPressed: onCancel ?? () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
                ),
                child: Text(
                  cancelText,
                  style: TextStyle(color: colorScheme.secondary),
                ),
              ),
              // زر التأكيد - بلون ثانوي مميز (عادة الأزرق)
              TextButton(
                onPressed: onConfirm,
                style: TextButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  confirmText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
