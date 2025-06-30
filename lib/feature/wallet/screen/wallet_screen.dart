import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20request/widgets/custom_text_field.dart';
import 'package:charity_app/feature/wallet/cubit/wallet_cubit.dart';
import 'package:charity_app/feature/wallet/cubit/wallet_states.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = context.colorScheme;

    // final String? balanceString = sharedPreferences.getString("balance");
    final String balanceString = sharedPreferences.getString("balance") ?? '0';
    double balanceValue = double.tryParse(balanceString) ?? 0.0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const ConstAppBar(title: "المحفظة"),
        backgroundColor: colorScheme.surface,
        body: BlocConsumer<WalletCubit, WalletStates>(
          listener: (context, state) {
            if (state is WalletSuccess) {
              balanceValue = state.newBalance;

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text("تم شحن المحفظة بمبلغ ${moneyController.text} " r"$"),
                backgroundColor: colorScheme.onSurface,
              ));
            }
            if (state is WalletFailure) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage),
              ));
            }
          },
          builder: (context, state) {
            if (state is WalletLoading) {
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
                      const SizedBox(width: 20),
                      Icon(
                        Icons.warning,
                        color: colorScheme.secondary,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "رصيدك الحالي: $balanceValue" r"$",
                        style: TextStyle(
                            fontSize: 14,
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
                              if (value.length != 4) {
                                return "يجب أن يحوي رقم حساب البنك على 4 رقم";
                              }
                              if (value.endsWith(".")) {
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
                        const SizedBox(height: 13),
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
