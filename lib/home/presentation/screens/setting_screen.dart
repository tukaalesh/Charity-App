import 'package:charity_app/auth/model/user_model.dart';
import 'package:charity_app/auth/presentation/widgets/alert_dialog.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/home/widget/initial_circle.dart';
import 'package:charity_app/home/widget/settings_row_item.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SettingDrawer extends StatelessWidget {
  const SettingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    final token = sharedPreferences.getString('token');
    return Drawer(
      backgroundColor: colorScheme.surface,
      child: FutureBuilder(
        future:
            Api().get(url: "http://127.0.0.1:8000/api/getUser", token: token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SpinKitCircle(color: colorScheme.primary));
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.hasData) {
            final data = Map<String, dynamic>.from(snapshot.data);
            final user = UserModel.fromJson(data['data']);

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Initialcircle(text: user.fullName[0].toUpperCase()),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.phoneNumber,
                              style: theme.textTheme.bodyLarge),
                          Flexible(
                            child: Text(user.email,
                                style: theme.textTheme.bodyLarge),
                          ),
                        ],
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(user.phoneNumber,
                      //         style: theme.textTheme.bodyLarge),
                      //     Expanded(
                      //       child: Text(user.email,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: theme.textTheme.bodyLarge),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: theme.dividerColor),
                SettingsRowItem(
                  onTap: () {
                    Navigator.pushNamed(context, 'ChangePassword');
                  },
                  text: "تغيير كلمة السر",
                  icon: Icon(Icons.lock_open_outlined,
                      color: colorScheme.onSurface),
                  color: colorScheme.onSurface,
                ),
                SettingsRowItem(
                  text: "الإشعارات",
                  icon: Icon(Icons.notifications_none_outlined,
                      color: colorScheme.onSurface),
                  color: colorScheme.onSurface,
                  onTap: () {
                    Navigator.pushNamed(context, 'Notification');
                  },
                ),
                SettingsRowItem(
                  text: "طلب التطوع",
                  icon: Icon(Icons.person_add_alt_1_outlined,
                      color: colorScheme.onSurface),
                  color: colorScheme.onSurface,
                  onTap: () => Navigator.pushNamed(context, 'Voluntary'),
                ),
                SettingsRowItem(
                  onTap: () => Navigator.pushNamed(context, 'Wallet'),
                  text: "التبرع لاحقاً",
                  icon: Icon(Icons.bookmark_outline,
                      color: colorScheme.onSurface),
                  color: colorScheme.onSurface,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, left: 16),
                      child: Switch(
                        activeTrackColor: colorScheme.primary,
                        activeColor: colorScheme.surface,
                        inactiveThumbColor: const Color(0xFF919593),
                        inactiveTrackColor: Colors.white,
                        value: isDark,
                        onChanged: (_) => context.themeCubit.toggleTheme(),
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
                          '١٠٠٠ نقطة',
                          style: TextStyle(
                            color: colorScheme.secondary,
                            fontSize: 20,
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
                  onTap: () => Navigator.pushNamed(context, 'Gift'),
                  text: "أبرز المحسنين",
                  icon: Icon(Icons.favorite_border_outlined,
                      color: colorScheme.onSurface),
                  color: colorScheme.onSurface,
                ),
                SettingsRowItem(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: "هل تريد بالتأكيد تسجيل الخروج",
                            textButton: "تأكيد",
                            onPressed: () {
                              sharedPreferences.clear();
                              Navigator.pushNamed(context, 'Welcom');
                            },
                            textButton1: "إلغاء",
                            onPressed1: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  text: "تسجيل الخروج",
                  icon:
                      Icon(Icons.logout_outlined, color: colorScheme.onSurface),
                  color: colorScheme.onSurface,
                ),
              ],
            );
          }

          return const Center(child: Text('Unexpected error!'));
        },
      ),
    );
  }
}
