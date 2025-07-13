import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/change_password/change_password_cubit.dart';
import 'package:charity_app/auth/cubits/pin_code_cubit/pin_code_cubit.dart';
import 'package:charity_app/auth/cubits/splash_cubits/splash_cubits.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_cubit.dart';
import 'package:charity_app/auth/screens/change_password_screen.dart';
import 'package:charity_app/auth/screens/login_screen.dart';
import 'package:charity_app/auth/screens/pin_code_screen.dart';
import 'package:charity_app/auth/screens/signup_screen.dart';
import 'package:charity_app/auth/screens/splash_screen.dart';
import 'package:charity_app/auth/screens/welcome_screen.dart';
import 'package:charity_app/core/theme/app_themes.dart';
import 'package:charity_app/feature/completed_projects/screen/completed_projects_screen.dart';
import 'package:charity_app/feature/gift/cubit/send_gift_cubit.dart';
import 'package:charity_app/feature/gift/screen/gift_screen.dart';
import 'package:charity_app/feature/monthly_donation/cubit/cancle_monthly_donation.dart';
import 'package:charity_app/feature/monthly_donation/cubit/monthly_donation_cubit.dart';
import 'package:charity_app/feature/monthly_donation/screens/enable_monthly_onation.dart';
import 'package:charity_app/feature/monthly_donation/screens/monthly_donation_screen.dart';
import 'package:charity_app/feature/notification/screen/notification_screen.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/join_to_project/join_to_project_cubit.dart';
import 'package:charity_app/feature/volunteer%20projects/screens/fields.dart';
import 'package:charity_app/feature/volunteer%20projects/screens/globalNetwork_projects.dart';
import 'package:charity_app/feature/volunteer%20projects/screens/healtcare_projects.dart';
import 'package:charity_app/feature/volunteer%20projects/screens/learning_projects_screen.dart';
import 'package:charity_app/feature/volunteer%20projects/screens/on_site_projects.dart';
import 'package:charity_app/feature/volunteer_form/cubit_request/voluntary_cubits.dart';
import 'package:charity_app/feature/volunteer_form/screen/form_screen.dart';
import 'package:charity_app/feature/wallet/cubit/wallet_cubit.dart';
import 'package:charity_app/feature/wallet/screen/wallet_screen.dart';
import 'package:charity_app/home/cubits/donation_repositry.dart';
import 'package:charity_app/home/cubits/navigation/navigation_cubit.dart';
import 'package:charity_app/home/cubits/project_cubit/donation_cubit.dart';
import 'package:charity_app/home/cubits/themeCubit/theme_cubit.dart';
import 'package:charity_app/home/screens/home_page.dart';
import 'package:charity_app/home/screens/navigation_main.dart';
import 'package:charity_app/home/screens/setting_drawer.dart';
import 'package:charity_app/zakat/cubit/zakah_cubit.dart';
import 'package:charity_app/zakat/screen/zakah_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
String? token;

//مشان ونحنا عم نعدل بين ايميوليتر و ويندوز

// const String localhost = "10.0.2.2:8000";

const String localhost = "127.0.0.1:8000";
// const String localhost = " 192.168.59.180:8000";
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
        BlocProvider(create: (context) => WalletCubit()),
        BlocProvider(create: (context) => SendGiftCubit()),
        BlocProvider(create: (context) => VoluntaryCubits()),
        BlocProvider(create: (context) => DonationCubit(DonationRepositry())),
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => PinCodeCubit()),
        BlocProvider(create: (context) => MonthlyDonationCubit()),
        BlocProvider(create: (context) => ZakahCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CancleMonthlyDonationCubit()),
        BlocProvider(create: (context) => JoinToProjectCubit()),
        // BlocProvider(create: (context) => BirthdateCubit())
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
            // builder: (context, child) {
            //   return Directionality(
            //     textDirection: TextDirection.rtl,
            //     child: child!,
            //   );
            // },
            initialRoute: "Splash",
            routes: {
              "Splash": (context) => const SplashScreen(),
              "NavigationMain": (context) => const NavigationMain(),
              "Home": (context) => const HomePage(),
              "SignUp": (context) => SignUpScreen(),
              "LogIn": (context) => LoginScreen(),
              "Welcom": (context) => const WelcomeScreen(),
              "ChangePassword": (context) => ChangePasswordScreen(),
              "PinCode": (context) => PinCodeScreen(),
              "VolunteerForm": (context) => const FormScreen(),
              "Gift": (context) => GiftScreen(),
              "Setting": (context) => const SettingDrawer(),
              "Wallet": (context) => WalletScreen(),
              "Notification": (context) => const NotificationScreen(),
              "VolunteeringFields": (context) => const VolunteeringFields(),
              "LearningProject": (context) => const LearningProject(),
              "OnSiteProjects": (context) => const OnSiteProjects(),
              "GlobalnetworkProjects": (context) =>
                  const GlobalnetworkProjects(),
              "HealtcareProjects": (context) => const HealtcareProjects(),
              "ZakahPage": (context) => const ZakahPage(),
              "MonthlyDonation": (context) => const MonthlyDonationScreen(),
              "EnableMonthlyOnation": (context) =>
                  const EnableMonthlyDonation(),
              "CompletedProjects": (context) => const CompletedProjectsScreen(),
            },
          );
        },
      ),
    );
  }
}
