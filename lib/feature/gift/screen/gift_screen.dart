// ignore_for_file: avoid_print
import 'package:charity_app/auth/cubits/user_cubit/user_cubit.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_states.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/auth/widgets/auth_custom_text_field.dart';
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/gift/cubit/send_gift_cubit.dart';
import 'package:charity_app/feature/gift/cubit/send_gift_states.dart';
import 'package:charity_app/feature/gift/widget/button_out_line.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class GiftScreen extends StatelessWidget {
  GiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController moneyController = TextEditingController();
    GlobalKey<FormState> fromKey = GlobalKey();
    final colorScheme = context.colorScheme;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<SendGiftCubit, SendGiftStates>(
            listener: (context, state) {
          final userCubit = context.read<UserCubit>();
          final userState = userCubit.state;

          if (state is SendGiftSuccess) {
            final donatedAmount = double.tryParse(moneyController.text) ?? 0;

            if (userState is UserSuccessState) {
              final currentBalance = userState.user.balance;
              final newBalance = currentBalance - donatedAmount.toInt();
              userCubit.updateBalance(newBalance);
            }

            nameController.clear();
            phoneController.clear();
            moneyController.clear();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CustomAlertDialogNoConfirm(
                title: "تم إرسال الإهداء جزاك الله خيراً",
                cancelText: "إغلاق",
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          }

          if (state is InsufficientBalance) {
            nameController.clear();
            phoneController.clear();
            moneyController.clear();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CustomAlertDialogNoConfirm(
                title:
                    "لا يوجد لديك رصيد كافي للقيام بهذه العملية، الرجاء شحن المحفظة والمحاولة مرة أُخرى",
                cancelText: "إغلاق",
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          }

          if (state is UnregisteredBeneficiary) {
            nameController.clear();
            phoneController.clear();
            moneyController.clear();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CustomAlertDialogNoConfirm(
                title:
                    "لقد حدث خطأ! يبدو أن هذا المحتاج غير مسجل لدينا في التطبيق، يمكنك دعوته للتسجيل على صفحة الويب الخاصة بنا",
                cancelText: "إغلاق",
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          }

          if (state is SendGiftFailure) {
            nameController.clear();
            phoneController.clear();
            moneyController.clear();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CustomAlertDialogNoConfirm(
                title: "حدث خطأ يُرجى المحاولة فيما بعد",
                cancelText: "إغلاق",
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          }
        }, builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                  backgroundColor: colorScheme.surface,
                  appBar: const ConstAppBar1(title: "الهدية "),
                  body: Form(
                    key: fromKey,
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 25.0, left: 5),
                          child: Text(
                            'كل تبرع هو بصمة خير تترك أثرًا في حياة شخص قريب هنا، بإمكانك أن تكون مصدر الأمل والفرح لمن تحب',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Text(
                            'بيانات المُهدى إليه ',
                            style: TextStyle(
                                fontSize: 15,
                                color: colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0, right: 13),
                          child: Customtextfields(
                              hint: "اسم المُهدى إليه",
                              inputType: TextInputType.name,
                              mycontroller: nameController,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "اسم المُهدى إليه مطلوب";
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0, right: 13),
                          child: Customtextfields(
                              hint: "رقم المُهدى إليه",
                              inputType: TextInputType.number,
                              mycontroller: phoneController,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "رقم المُهدى إليه مطلوب";
                                }
                                if (!value.startsWith("09")) {
                                  return "يجب أن يبدأ الرقم ب 09";
                                }
                                if (value.length != 10) {
                                  return "يجب أن يتكون الرقم من 10 أرقام";
                                }
                                if (value.startsWith(".") ||
                                    value.startsWith(",") ||
                                    value.startsWith("-")) {
                                  return "يُرجى إدخال الرقم بطريقة صحيحة";
                                }
                                if (value.contains(".") ||
                                    value.contains(",") ||
                                    value.contains("-")) {
                                  return "يُرجى إدخال الرقم بطريقة صحيحة";
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, right: 25.0),
                          child: Text(
                            "مبلغ التبرع",
                            style: TextStyle(
                                fontSize: 14,
                                color: colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            ButtonOutlined(
                              buttonText: r'100 $',
                              onPressed: () {
                                moneyController.text = "100";
                              },
                              borderColor: colorScheme.primary,
                              textColor: colorScheme.primary,
                            ),
                            ButtonOutlined(
                              buttonText: r'200 $',
                              onPressed: () {
                                moneyController.text = "200";
                              },
                              borderColor: colorScheme.primary,
                              textColor: colorScheme.primary,
                            ),
                            ButtonOutlined(
                              buttonText: r'300 $',
                              onPressed: () {
                                moneyController.text = "300";
                              },
                              borderColor: colorScheme.primary,
                              textColor: colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0, right: 13),
                          child: AuthCustomTextField(
                              hint: 'مبلغ التبرع',
                              icon: const Icon(Icons.attach_money),
                              inputType: TextInputType.number,
                              mycontroller: moneyController,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "مبلغ التبرع مطلوب";
                                }
                                if (value.startsWith("0")) {
                                  return " يرجى إدخال الرقم بطريقة صحيحة";
                                }
                                if (value.endsWith(".")) {
                                  return "يُرجى إدخال الرقم بطريقة صحيحة";
                                }
                                if (value.contains(",") ||
                                    value.contains("-")) {
                                  return "يُرجى إدخال الرقم بطريقة صحيحة";
                                }
                                if (value.startsWith(".") ||
                                    value.startsWith(",") ||
                                    value.startsWith("-")) {
                                  return "يُرجى إدخال الرقم بطريقة صحيحة";
                                }
                                return null;
                              },
                              color: colorScheme.secondary),
                        ),
                        const SizedBox(
                          height: 27,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0, right: 13),
                          child: Authbutton(
                              buttonText: "إرسال",
                              onPressed: () {
                                if (fromKey.currentState!.validate()) {
                                  BlocProvider.of<SendGiftCubit>(context)
                                      .sendGift(
                                          nameController: nameController,
                                          phoneController: phoneController,
                                          moneyController: moneyController);
                                }
                              },
                              color: colorScheme.secondary),
                        )
                      ],
                    ),
                  )),
              if (state is SendGiftLoading)
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
        }));
  }
}
