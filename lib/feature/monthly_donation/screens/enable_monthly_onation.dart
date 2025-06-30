import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/auth/widgets/custom_text_field.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/gift/widget/button_out_line.dart';
import 'package:charity_app/feature/monthly_donation/cubit/monthly_donation_cubit.dart';
import 'package:charity_app/feature/monthly_donation/cubit/monthly_donation_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class EnableMonthlyOnation extends StatelessWidget {
  EnableMonthlyOnation({super.key});
  final TextEditingController moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    GlobalKey<FormState> formKey = GlobalKey();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: const ConstAppBar(title: "تفعيل التبرع الشهري"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<MonthlyDonationCubit, MonthlyDonationStates>(
            listener: (context, state) {
              if (state is editStates) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "تم تعديل المبلغ بنجاح، سيتم اقتطاع ${moneyController.text} من حسابك في بداية كل شهر، جزاك الله خيراً🙏🏻"),
                ));
              }
              if (state is successStates) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "تم تفعيل التبرع الشهري بنجاح، سيتم اقتطاع ${moneyController.text} من حسابك في بداية كل شهر، جزاك الله خيراً🙏🏻"),
                ));
              }
              if (state is failureStates) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("هناك مشكلة ما ! يُرجى المحاولة لاحقاً"),
                ));
              }
            },
            builder: (context, state) {
              if (state is loadingStates) {
                return Center(
                  child: SpinKitCircle(
                    color: colorScheme.secondary,
                    size: 45,
                  ),
                );
              }
              return Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 18),
                    const Text(
                      "يرجى تحديد المبلغ الذي ترغب بالتبرع به شهرياً",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Wrap(
                        spacing: 1,
                        runSpacing: 2,
                        children: [
                          ButtonOutlined(
                            buttonText: r'100 $',
                            onPressed: () => moneyController.text = "100",
                            borderColor: colorScheme.primary,
                            textColor: colorScheme.primary,
                          ),
                          ButtonOutlined(
                            buttonText: r'200 $',
                            onPressed: () => moneyController.text = "200",
                            borderColor: colorScheme.primary,
                            textColor: colorScheme.primary,
                          ),
                          ButtonOutlined(
                            buttonText: r'300 $',
                            onPressed: () => moneyController.text = "300",
                            borderColor: colorScheme.primary,
                            textColor: colorScheme.primary,
                          ),
                          // ButtonOutlined(
                          //   buttonText: r'400 $',
                          //   onPressed: () => moneyController.text = "400",
                          //   borderColor: colorScheme.primary,
                          //   textColor: colorScheme.primary,
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Customtextfield(
                          hint: 'مبلغ التبرع',
                          icon: const Icon(Icons.attach_money),
                          inputType: TextInputType.number,
                          mycontroller: moneyController,
                          valid: (value) {
                            if (value!.isEmpty) {
                              return "مبلغ التبرع مطلوب";
                            }
                            if (value.startsWith("0") ||
                                value.startsWith(".") ||
                                value.startsWith(",") ||
                                value.startsWith("-") ||
                                value.endsWith(".") ||
                                value.contains(",") ||
                                value.contains("-")) {
                              return "يُرجى إدخال الرقم بطريقة صحيحة";
                            }
                            return null;
                          },
                          color: colorScheme.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Authbutton(
                          buttonText: "تأكيد",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<MonthlyDonationCubit>(context)
                                  .enableMonthlyDonation(
                                      moneyController: moneyController);
                            }
                          },
                          color: colorScheme.secondary),
                    ),
                    // BottonMonthlyDonation(
                    //     onPressed: () {
                    //       if (formKey.currentState!.validate()) {
                    //         BlocProvider.of<MonthlyDonationCubit>(context)
                    //             .enableMonthlyDonation(
                    //                 moneyController: moneyController);
                    //       }
                    //     },
                    //     text: "تأكيد"),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
