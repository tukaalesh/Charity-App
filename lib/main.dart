import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/change_password/change_password_cubit.dart';
import 'package:charity_app/auth/cubits/splash_cubits/splash_cubits.dart';
import 'package:charity_app/auth/presentation/screens/change_password_screen.dart';
import 'package:charity_app/auth/presentation/screens/login_screen.dart';
import 'package:charity_app/auth/presentation/screens/pin_code_screen.dart';
import 'package:charity_app/auth/presentation/screens/signup_screen.dart';
import 'package:charity_app/auth/presentation/screens/splash_screen.dart';
import 'package:charity_app/auth/presentation/screens/welcome_screen.dart';
import 'package:charity_app/core/theme/app_themes.dart';
import 'package:charity_app/gift/presentation/screen/gift_screen.dart';
import 'package:charity_app/home/cubit/theme_cubit/theme_cubits.dart';
import 'package:charity_app/home/presentation/screens/home_screen.dart';
import 'package:charity_app/home/presentation/screens/setting_screen.dart';
import 'package:charity_app/notification/presentation/screen/notification_screen.dart';
import 'package:charity_app/voluntary/presentation/screen/voluntary_screen.dart';
import 'package:charity_app/voluntary/presentation/screen/volunteering_fields.dart';
import 'package:charity_app/wallet/presentation/screen/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  final isDarkMode = sharedPreferences.getBool('isDarkMode') ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubits()),
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => ThemeCubits(isDarkMode)),
        BlocProvider(create: (context) => ChangePasswordCubit()),
      ],
      child: BlocBuilder<ThemeCubits, bool>(
        builder: (context, isDarkMode) {
          final theme = AppThemes.getTheme(isDarkMode);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme.copyWith(
              textTheme: theme.textTheme.apply(
                fontFamily: 'IBMPlexSansArabic',
              ),
            ),
            initialRoute: "VolunteeringFields",
            routes: {
              "Splash": (context) => const SplashScreen(),
              "Home": (context) => const HomeScreen(),
              "SignUp": (context) => SignUpScreen(),
              "LogIn": (context) => LoginScreen(),
              "Welcom": (context) => const WelcomeScreen(),
              "ChangePassword": (context) => ChangePasswordScreen(),
              "PinCode": (context) => PinCodeScreen(),
              "Voluntary": (context) => const VoluntaryScreen(),
              "Gift": (context) => GiftScreen(),
              "Setting": (context) => const SettingDrawer(),
              "Wallet": (context) => WalletScreen(),
              "Notification": (context) => const NotificationScreen(),
              "VolunteeringFields": (context) => const VolunteeringFields(),
            },
          );
        },
      ),
    );
  }
}
