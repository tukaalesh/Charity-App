import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/voluntary/widgets/custom_text_field.dart';
import 'package:charity_app/feature/wallet/cubit/wallet_cubit.dart';
import 'package:charity_app/feature/wallet/cubit/wallet_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});
  TextEditingController bankAccountController = TextEditingController();
  TextEditingController moneyController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = context.colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar(title: "المحفظة"),
        backgroundColor: colorScheme.surface,
        body: BlocConsumer<WalletCubit, WalletStates>(
          listener: (context, state) {
            if (state is SuccessState) {
              //بيضرب ايرور بدون هاد الشي تبع كلير سناك بار
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$moneyController تم شحن المحفظة بمبلغ "),
                backgroundColor: colorScheme.primary,
              ));
            }
            if (state is FailureState) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("هناك مشكلة ما ! يُرجى المحاولة لاحقاً"),
              ));
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
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
                  SizedBox(
                      width: double.infinity,
                      height: size.height * 0.44,
                      child: walletImage),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.warning,
                        color: colorScheme.secondary,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        r" رصيدك الحالي : 500$",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        Customtextfields(
                            hint: "رقم حساب البنك",
                            inputType: TextInputType.number,
                            mycontroller: bankAccountController,
                            valid: (value) {
                              if (value!.isEmpty) {
                                return "رقم حساب البنك مطلوب ";
                              }
                              if (value.length < 6) {
                                return "في خطأ برقم حساب البنك";
                              }
                              if (value.endsWith(".") )
                                  {
                                return "يُرجى إدخال الرقم بطريقة صحيحة";
                              }
                              if (value.contains(".") ||
                                  value.contains(",") ||
                                  value.contains("-")) {
                                return "يُرجى إدخال الرقم بطريقة صحيحة";
                              }
                              if (value.startsWith(".") ||
                                  value.startsWith(",") ||
                                  value.startsWith("-")) {
                                return "يُرجى إدخال الرقم بطريقة صحيحة";
                              }

                              return null;
                            }),
                        const SizedBox(
                          height: 13,
                        ),
                        Customtextfields(
                            hint: "المبلغ المراد شحنه",
                            inputType: TextInputType.number,
                            mycontroller: moneyController,
                            valid: (value) {
                              if (value!.isEmpty) {
                                return "المبلغ المراد شحنه مطلوب";
                              }

                              if (value.startsWith(".") ||
                                  value.startsWith(",") ||
                                  value.startsWith("0") ||
                                  value.startsWith("-")) {
                                return "يُرجى إدخال الرقم بطريقة صحيحة";
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Authbutton(
                        buttonText: "تأكيد",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<WalletCubit>(context).chargeWallet(
                                bankAccountController: bankAccountController,
                                moneyController: moneyController);
                          }
                        },
                        color: colorScheme.secondary),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
