import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_cubit.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_states.dart';
import 'package:charity_app/auth/widgets/alert_dialog.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/widgets/initial_circle.dart';
import 'package:charity_app/home/widgets/settings_rowItem.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SettingDrawer extends StatelessWidget {
  const SettingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    final token = sharedPreferences.getString('token');
//س=هون مابدي ياه يبني شي بس بدي ياه يعمل لوغ اوت
    return BlocListener<AuthCubits, AuthStates>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          sharedPreferences.clear();
          Navigator.pushNamedAndRemoveUntil(
              context, 'Welcom', (route) => false);
        } else if (state is LogOutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("فشل تسجيل الخروج")),
          );
        }
      },
      child: Drawer(
        backgroundColor: colorScheme.surface,

        //ليش بلوك بيلدر ؟؟
        // لانو انا حسب كل حالة عم تنبنى ui جديدة

        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserInitialState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<UserCubit>().getUserData(token!);
              });
              return Center(child: SpinKitCircle(color: colorScheme.primary));
            }

            if (state is UserLoadingState) {
              return Center(child: SpinKitCircle(color: colorScheme.primary));
            }

            if (state is UserErrorState) {
              return Center(child: Text("Error: ${state.message}"));
            }

            if (state is UserSuccessState) {
              final user = state.user;

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  const SizedBox(height: 30),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Initialcircle(
                          text: (user.fullName.isNotEmpty
                              ? user.fullName[0].toUpperCase()
                              : '?'),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.phoneNumber.isNotEmpty
                                    ? user.phoneNumber
                                    : "09xxxxxxxx",
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                user.email.isNotEmpty
                                    ? user.email
                                    : "البريد غير متوفر",
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: theme.dividerColor),
                  SettingsRowItem(
                    onTap: () => Navigator.pushNamed(context, 'ChangePassword'),
                    text: "تغيير كلمة السر",
                    icon: Icon(Icons.lock_open_outlined,
                        color: colorScheme.onSurface),
                    color: colorScheme.onSurface,
                  ),
                  SettingsRowItem(
                    onTap: () => Navigator.pushNamed(context, 'Notification'),
                    text: "الإشعارات",
                    icon: Icon(Icons.notifications_none_outlined,
                        color: colorScheme.onSurface),
                    color: colorScheme.onSurface,
                  ),
                  SettingsRowItem(
                    // onTap: () =>
                    //     Navigator.pushNamed(context, 'MonthlyDonation'),
                    text: "سجل التبرع",
                    icon: Icon(Icons.history, color: colorScheme.onSurface),
                    color: colorScheme.onSurface,
                  ),
                  SettingsRowItem(
                    text: "التبرع لاحقاً",
                    icon: Icon(Icons.bookmark_outline,
                        color: colorScheme.onSurface),
                    color: colorScheme.onSurface,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            activeTrackColor: colorScheme.primary,
                            activeColor: colorScheme.surface,
                            inactiveThumbColor: const Color(0xFF919593),
                            inactiveTrackColor: Colors.white,
                            value: isDark,
                            onChanged: (_) => context.themeCubit.toggleTheme(),
                          ),
                        ),
                      ),
                      SettingsRowItem(
                        text: "الوضع الليلي",
                        icon: Icon(Icons.dark_mode_outlined,
                            color: colorScheme.onSurface),
                        color: colorScheme.onSurface,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28.0, left: 10),
                          child: Text(
                            "نقطة ${user.points}",
                            style: TextStyle(
                              color: colorScheme.secondary,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SettingsRowItem(
                        text: "عدد نقاطك",
                        icon: Icon(Icons.emoji_events_outlined,
                            color: colorScheme.onSurface),
                        color: colorScheme.onSurface,
                      ),
                    ],
                  ),
                  SettingsRowItem(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => CustomAlertDialog(
                          title: "هل تريد بالتأكيد تسجيل الخروج",
                          textButton: "تأكيد",
                          onPressed: () {
                            Navigator.pop(context);
                            context.read<AuthCubits>().logOutFunction();
                          },
                          textButton1: "إلغاء",
                          onPressed1: () => Navigator.pop(context),
                        ),
                      );
                    },
                    text: "تسجيل الخروج",
                    icon: Icon(Icons.logout_outlined,
                        color: colorScheme.onSurface),
                    color: colorScheme.onSurface,
                  ),
                 
                ],
              );
            }

            return const Center(child: Text("Unexpected error"));
          },
        ),
      ),
    );
  }
}
