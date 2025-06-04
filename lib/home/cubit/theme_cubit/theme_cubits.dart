import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class ThemeCubits extends Cubit<ThemeData> {
//   static final ThemeData lightTheme = ThemeData.light();
//   static final ThemeData darkTheme = ThemeData.dark();

//   ThemeCubits() : super(lightTheme);

//   void toogletheme() {
//     if (state == lightTheme) {
//       emit(darkTheme);
//     } else {
//       emit(lightTheme);
//     }
//   }
// }


class ThemeCubits extends Cubit<bool> {
  // ignore: use_super_parameters
  ThemeCubits(bool isDarkMode) : super(isDarkMode);

  void toggleTheme() {
    final newMode = !state;
    emit(newMode);
    sharedPreferences.setBool('isDarkMode', newMode); 
  }
}
