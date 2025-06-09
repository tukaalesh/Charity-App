// ignore: file_names
import 'package:flutter/material.dart';

class Pickdate {
  int? age;
  Future<void> pickDate(
      BuildContext context, TextEditingController birthDateController) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1994),
      lastDate: DateTime(2005),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
              ),
            ),
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: colorScheme.primary,
                    onPrimary: colorScheme.onPrimary,
                    onSurface: colorScheme.onSurface,
                  )
                : ColorScheme.light(
                    primary: colorScheme.primary,
                    onPrimary: colorScheme.onPrimary,
                    onSurface: colorScheme.onSurface,
                  ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final now = DateTime.now();
      age = now.year - picked.year;
      if (now.month < picked.month ||
          (now.month == picked.month && now.day < picked.day)) {
        age = age! - 1;
      }

      final formatted =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      birthDateController.text = "$formatted (العمر: $age سنة)";
    }
  }
}
