import 'package:charity_app/auth/cubits/change_password/change_password_cubit.dart';
import 'package:charity_app/auth/cubits/change_password/change_password_states.dart';
import 'package:charity_app/auth/widgets/alert_dialog.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/auth/widgets/custom_text_field.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmationNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        resizeToAvoidBottomInset: true,
        appBar: const ConstAppBar(title: "تغيير كلمة السر"),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "تم تغيير كلمة السر",
                ),
               
              ));
            }
            if (state is ChangePasswordFailure) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("لم يتم تغيير كلمة السر يُرجى المحاولة لاحقاً")));
            }
          },
          builder: (context, state) {
            if (state is ChangePasswordLoading) {
              return SpinKitCircle(
                color: colorScheme.secondary,
                size: 45,
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: size.height * 0.35,
                        width: double.infinity,
                        child: resetPasswordImage,
                      ),
                      const SizedBox(height: 30),
                      // Center(
                      //   child: Text(
                      //     'ادخل كلمة السر الجديدة',
                      //     style: TextStyle(
                      //       color: colorScheme.onSurface,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Customtextfield(
                        hint: ' ادخل كلمة المرور الجديدة',
                        icon: Icon(BoxIcons.bx_lock_alt,
                            color: colorScheme.secondary),
                        inputType: TextInputType.visiblePassword,
                        mycontroller: newPasswordController,
                        color: colorScheme.secondary,
                        isPassword: true,
                        valid: (value) {
                          if (value!.isEmpty) return " يرجى إدخال كلمة المرور";
                          if (value.length < 8) {
                            return "يجب أن تحتوي على 8 أحرف على الأقل";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Customtextfield(
                        hint: "ادخل تأكيد كلمة المرور الجديدة",
                        icon: Icon(BoxIcons.bx_lock_alt,
                            color: colorScheme.secondary),
                        inputType: TextInputType.visiblePassword,
                        mycontroller: confirmationNewPasswordController,
                        isPassword: true,
                        color: colorScheme.secondary,
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return " يرجى إدخال تأكيد كلمة المرور";
                          } else if (value.length < 8) {
                            return " يجب أن تكون كلمة المرور مكونة من 8 أحرف على الأقل";
                          } else if (value != newPasswordController.text) {
                            return "كلمة المرور غير متطابقة";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: size.width,
                        child: Authbutton(
                          buttonText: 'تأكيد',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    title: "هل تريد تغيير كلمة السر بالفعل؟",
                                    textButton1: "تأكيد",
                                    onPressed1: () {
                                      BlocProvider.of<ChangePasswordCubit>(
                                              context)
                                          .changePasswordFunction(
                                              newPasswordController:
                                                  newPasswordController,
                                              confirmationNewPasswordController:
                                                  confirmationNewPasswordController);
                                      Navigator.of(context).pop();
                                    },
                                    textButton: 'إلغاء',
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            }
                          },
                          color: colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
