import 'package:charity_app/auth/cubits/pin_code_cubit/pin_code_cubit.dart';
import 'package:charity_app/auth/cubits/pin_code_cubit/pin_code_states.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/feature/volunteer%20request/widgets/custom_text_field.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PinCodeScreen extends StatelessWidget {
  PinCodeScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController verificationController = TextEditingController();
  final String? email = sharedPreferences.get("email")?.toString();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<PinCodeCubit, PinCodeStates>(
        listener: (context, state) {
          if (state is PinCodeSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, 'LogIn');
            });
          } else if (state is PinCodeFailure) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(
                const SnackBar(
                  content: Center(
                      child:
                          Text("رمز التحقق غير صحيح، يرجى المحاولة مرة أخرى")),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state is PinCodeLoading) {
            return Center(
              child: SpinKitCircle(
                color: colorScheme.secondary,
                size: 45,
              ),
            );
          }

          return Directionality(
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
                  const Center(
                    child: Text(
                      "الرجاء إدخال رمز التحقق المرسل إلى بريدك الإلكتروني",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Customtextfields(
                      hint: "رمز التأكيد مكون من 4 أرقام",
                      inputType: TextInputType.number,
                      mycontroller: verificationController,
                      valid: (value) {
                        if (value == null || value.length != 4) {
                          return "يُرجى إدخال الرمز المكون من 4 أرقام";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
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
          );
        },
      ),
    );
  }
}
