// ignore_for_file: avoid_print
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/auth/widgets/auth_custom_text_field.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  GlobalKey<FormState> fromKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<SendGiftCubit, SendGiftStates>(
            listener: (context, state) {
          if (state is SendGiftSuccess) {
            nameController.clear();
            phoneController.clear();

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("تم إرسال الإهداء جزالك الله خيراً"),
            ));
            moneyController.clear();
          }
          if (state is InsufficientBalance) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 3),
              content: Text(
                  "لا يوجد لديك رصيد كافي للقيام بهذه العملية، الرجاء شحن المحفظة والمحاولة مرة أخرى"),
            ));
          }
          if (state is UnregisteredBeneficiary) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 3),
              content: Text(
                  "لقد حدث خطأ! يبدو أن هذا المحتاج غير مسجل لدينا في التطبيق، يمكنك دعوته للتسجيل على صفحة الويب الخاصة بنا"),
            ));
          }
          if (state is SendGiftFailure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 3),
              content: Text("حدث خطأ يُرجى المحاولة فيما بعد"),
            ));
          }
        }, builder: (context, state) {
          // if (state is SendGiftLoading) {
          //   return Center(
          //     child: SpinKitCircle(
          //       color: colorScheme.secondary,
          //       size: 45,
          //     ),
          //   );
          // }
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
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Text(
                            'بيانات المُهدى إليه ',
                            style: TextStyle(
                                fontSize: 14,
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
                          height: 14,
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
