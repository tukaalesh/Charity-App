import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'birthdate_states.dart';

class BirthdateCubit extends Cubit<BirthdateStates> {
  BirthdateCubit() : super(DefaultDateState());
Future<void> pickBirthDate(BuildContext context) async {
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
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    final now = DateTime.now();
    int age = now.year - picked.year;
    if (now.month < picked.month || (now.month == picked.month && now.day < picked.day)) {
      age--;
    }
    emit(PickDateState(picked, age));
  }
}

}
