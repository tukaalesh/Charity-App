import 'package:charity_app/auth/cubits/user_cubit/user_cubit.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_states.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/auth/widgets/auth_custom_text_field.dart';
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/custom_text.dart';
import 'package:charity_app/feature/wallet/cubit/wallet_cubit.dart';
import 'package:charity_app/feature/wallet/cubit/wallet_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TextEditingController bankAccountController = TextEditingController();

  final TextEditingController moneyController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = context.colorScheme;
    // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<WalletCubit, WalletStates>(
        listener: (context, state) {
          if (state is WalletSuccess) {
            final chargedAmount = moneyController.text;
            bankAccountController.clear();
            passwordController.clear();
            moneyController.clear();

            //تحديث الرصيد فوراً
            final userCubit = context.read<UserCubit>();
            final userState = userCubit.state;
            if (userState is UserSuccessState) {
              final currentBalance = userState.user.balance;
              final newBalance = currentBalance + int.parse(chargedAmount);
              userCubit.updateBalance(newBalance);
            }

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "تم شحن المحفظة بمبلغ $chargedAmount \$",
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: colorScheme.onSurface,
              ),
            );
            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) => CustomAlertDialogNoConfirm(
            //     title: "تم شحن المحفظة بمبلغ $chargedAmount \$",
            //     cancelText: "إغلاق",
            //     onCancel: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // );
          }
          if (state is WalletFailure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  "حدث خطأ ما ! يُرجى إاعادة المحاولة",
                  textDirection: TextDirection.rtl,
                ),
                backgroundColor: colorScheme.onSurface,
              ),
            );
            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) => CustomAlertDialogNoConfirm(
            //     title: "حدث خطأ ما ! يُرجى إاعادة المحاولة",
            //     cancelText: "إغلاق",
            //     onCancel: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: const ConstAppBar1(title: "المحفظة"),
                backgroundColor: colorScheme.surface,
                body: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.40,
                        child: walletImage,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 13.0, right: 13, bottom: 20),
                        child: Column(
                          children: [
                            Customtextfields(
                              hint: " رقم حساب البنك مكون من 4 خانات",
                              inputType: TextInputType.number,
                              mycontroller: bankAccountController,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "رقم حساب البنك مطلوب ";
                                }
                                if (value.length != 4) {
                                  return "يجب أن يحوي رقم حساب البنك على 4 أرقام";
                                }
                                if (value.endsWith(".") ||
                                    value.contains(RegExp(r'[.,-]')) ||
                                    value.startsWith(RegExp(r'[.,-]'))) {
                                  return "يُرجى إدخال الرقم بطريقة صحيحة";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            AuthCustomTextField(
                              hint: "كلمة السر الخاصة ببطاقتك",
                              icon: const Icon(BoxIcons.bx_lock_alt),
                              inputType: TextInputType.visiblePassword,
                              mycontroller: passwordController,
                              color: colorScheme.secondary,
                              isPassword: true,
                              valid: (value) {
                                if (value!.isEmpty) return "كلمة المرور مطلوبة";
                                if (value.length < 8) {
                                  return "يجب أن تحتوي على 8 أحرف على الأقل";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Customtextfields(
                              hint: "المبلغ المراد شحنه",
                              inputType: TextInputType.number,
                              mycontroller: moneyController,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "المبلغ المراد شحنه مطلوب";
                                }
                                if (value.startsWith(RegExp(r'[.,0-]'))) {
                                  return "يُرجى إدخال الرقم بطريقة صحيحة";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 15),
                        child: Authbutton(
                          buttonText: "تأكيد",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<WalletCubit>(context)
                                  .chargeWallet(
                                bankAccountController: bankAccountController,
                                moneyController: moneyController,
                              );
                            }
                          },
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is WalletLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.6),
                  child: Center(
                    child: SpinKitCircle(
                      color: colorScheme.secondary,
                      size: 45,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
