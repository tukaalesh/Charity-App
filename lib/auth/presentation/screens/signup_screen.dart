import 'package:charity_app/auth/cubits/auth_cubits/auth_cubits.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/auth/presentation/widgets/auth_button.dart';
import 'package:charity_app/auth/presentation/widgets/custom_text_field.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocConsumer<AuthCubits, AuthStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Center(child: Text(" تم إنشاء الحساب بنجاح ")),
                backgroundColor: colorScheme.secondary,
              ),
            );
            Navigator.pushNamed(context, 'LogIn');
          } else if (state is RegisterFailureState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Center(child: Text("الإيميل أو رقم الهاتف مستخدم سابقاً")),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingStates) {
            return Center(
              child: SpinKitCircle(
                color: colorScheme.secondary,
                size: 45,
              ),
            );
          }

          return SafeArea(
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: screenSize.width * 0.2,
                        height: screenSize.width * 0.2,
                        child: charityLogoImage),
                    const Text(
                      'إنشاء حساب',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                  ),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Customtextfield(
                              hint: 'ادخل اسمك الثلاثي',
                              icon: const Icon(BoxIcons.bx_user),
                              inputType: TextInputType.name,
                              mycontroller: fullNameController,
                              color: colorScheme.secondary,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "الاسم مطلوب";
                                }
                                return null;
                              }),
                          const SizedBox(height: 12),
                          Customtextfield(
                              hint: 'ادخل بريدك الإلكتروني',
                              icon: const Icon(BoxIcons.bx_envelope),
                              inputType: TextInputType.emailAddress,
                              mycontroller: emailController,
                              color: colorScheme.secondary,
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return "البريد الإلكتروني مطلوب";
                                }
                                return null;
                              }),
                          const SizedBox(height: 12),
                          Customtextfield(
                            hint: 'ادخل رقم هاتفك',
                            icon: const Icon(BoxIcons.bx_phone),
                            inputType: TextInputType.phone,
                            mycontroller: phoneNumberController,
                            color: colorScheme.secondary,
                            valid: (value) {
                              if (value!.isEmpty) return "رقم الهاتف مطلوب";
                              if (value.length != 10) {
                                return "رقم الهاتف يجب أن يكون 10 أرقام";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          Customtextfield(
                            hint: 'ادخل كلمة المرور',
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
                          const SizedBox(height: 12),
                          Customtextfield(
                            hint: 'ادخل تأكيد كلمة المرور',
                            icon: const Icon(BoxIcons.bx_lock_alt),
                            inputType: TextInputType.visiblePassword,
                            mycontroller: passwordConfirmationController,
                            color: colorScheme.secondary,
                            isPassword: true,
                            valid: (value) {
                              if (value!.isEmpty) {
                                return "يرجى تأكيد كلمة المرور";
                              }
                              if (value != passwordController.text) {
                                return "كلمة المرور غير متطابقة";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          Authbutton(
                            buttonText: "إنشاء حساب",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubits>(context)
                                    .signUpFunction(
                                  fullNameController: fullNameController,
                                  emailController: emailController,
                                  passwordConfirmationController:
                                      passwordConfirmationController,
                                  passwordController: passwordController,
                                  phoneNumberController: phoneNumberController,
                                );
                              }
                            },
                            color: colorScheme.secondary,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'LogIn');
                                },
                                child: Text(
                                  'تسجيل الدخول',
                                  style:
                                      TextStyle(color: colorScheme.secondary),
                                ),
                              ),
                              Text(' لديك حساب بالفعل ؟ ',
                                  style:
                                      TextStyle(color: colorScheme.onSurface)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
