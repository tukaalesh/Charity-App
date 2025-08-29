// ignore_for_file: use_super_parameters

import 'package:charity_app/auth/cubits/pin_code_cubit/pin_code_cubit.dart';
import 'package:charity_app/auth/cubits/pin_code_cubit/pin_code_states.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeScreen extends StatelessWidget {
  PinCodeScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController verificationController = TextEditingController();
  final String? email = sharedPreferences.get("email")?.toString();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;
    final isDark = context.isDarkMode;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<PinCodeCubit, PinCodeStates>(
        listener: (context, state) {
          if (state is PinCodeSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, 'LogIn');
            });
          } else if (state is PinCodeFailure) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CustomAlertDialogNoConfirm(
                title: "رمز التحقق غير صحيح، يرجى المحاولة مرة أخرى",
                cancelText: "إغلاق",
                onCancel: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is PinCodeLoading;

          return Stack(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.55,
                        child: pinCodeImage,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 50.0),
                        child: Text(
                          "الرجاء إدخال رمز التحقق المرسل إلى بريدك الإلكتروني",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Customtextfields(
                      //   hint: "رمز التأكيد مكون من 4 أرقام",
                      //   inputType: TextInputType.number,
                      //   mycontroller: verificationController,
                      //   valid: (value) {
                      //     if (value == null || value.length != 4) {
                      //       return "يُرجى إدخال الرمز المكون من 4 أرقام";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4,
                          controller: verificationController,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.scale,
                          cursorColor: colorScheme.secondary,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(12),
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeFillColor:
                                isDark ? Colors.grey[800]! : Colors.white,
                            inactiveFillColor:
                                isDark ? Colors.grey[700]! : Colors.white,
                            selectedFillColor: isDark
                                ? colorScheme.secondary.withOpacity(0.2)
                                : colorScheme.secondary.withOpacity(0.1),
                            activeColor: colorScheme.secondary,
                            inactiveColor: colorScheme.secondary,
                            selectedColor: colorScheme.secondary,
                          ),
                          enableActiveFill: true,
                          animationDuration: const Duration(milliseconds: 250),
                          validator: (value) {
                            if (value == null || value.length != 4) {
                              return "يُرجى إدخال الرمز المكون من 4 أرقام";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),
                      ),

                      const SizedBox(height: 10),
                      Authbutton(
                        buttonText: "تأكيد",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<PinCodeCubit>(context).checkCode(
                              email: email ?? "",
                              code: verificationController.text,
                            );
                          }
                        },
                        color: colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3),
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
