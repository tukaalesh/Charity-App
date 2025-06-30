import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20request/cubit/cubit_request/voluntary_cubits.dart';
import 'package:charity_app/feature/volunteer%20request/cubit/cubit_request/voluntary_states.dart';
import 'package:charity_app/feature/volunteer%20request/widgets/custom_text_field.dart';
import 'package:charity_app/feature/volunteer%20request/widgets/row_dropdown.dart';
//مو خالصة  بدي ابدا ابدا
// import 'package:charity_app/feature/voluntary/helper/pickDate.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VoluntaryScreen extends StatefulWidget {
  const VoluntaryScreen({super.key});

  @override
  State<VoluntaryScreen> createState() => _VoluntaryScreenState();
}

class _VoluntaryScreenState extends State<VoluntaryScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  String? selectedGender;
  String? selectedLevel;
  String? selectedDomain;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: const ConstAppBar(title: "طلب التطوع"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<VoluntaryCubits, VoluntaryState>(
              listener: (context, state) {
            if (state is VoluntarySuccess) {
              //بيضرب ايرور بدون هاد الشي تبع كلير سناك بار
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("تم إرسال طلب التطوع بنجاح"),
              ));
            }
            if (state is VoluntaryFailure) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("هناك مشكلة ما ! يُرجى المحاولة لاحقاً"),
              ));
            }
          }, builder: (context, state) {
            if (state is VoluntaryLoading) {
              return Center(
                child: SpinKitCircle(
                  color: colorScheme.primary,
                  size: 45,
                ),
              );
            }
            return Form(
              key: formKey,
              child: ListView(
                children: [
                  Customtextfields(
                    hint: "رقم للتواصل",
                    inputType: TextInputType.phone,
                    mycontroller: phoneController,
                    valid: (value) {
                      if (value!.isEmpty) return "رقم الهاتف مطلوب";
                      if (value.length != 10) {
                        return "رقم الهاتف يجب أن يكون 10 أرقام";
                      }
                      if (!value.startsWith("09")) {
                        return "يجب أن يبدأ الرقم ب 09";
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
                    },
                  ),
                  const SizedBox(height: 10),

                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {});
                  //     Pickdate().pickDate(context, birthDateController);
                  //   },
                  //   child: AbsorbPointer(
                  //     child:
                  Customtextfields(
                    hint: "العمر",
                    inputType: TextInputType.number,
                    mycontroller: birthDateController,
                    valid: (value) {
                      // if (birthDateController.text.isEmpty) {
                      //   return "العمر مطلوب";
                      // }
                      if (value!.isEmpty) {
                        return "العمر مطلوب";
                      }
                      if (value.contains(".") ||
                          value.contains(",") ||
                          value.contains("-")) {
                        return "يُرجى إدخال العمر بطريقة صحيحة";
                      }
                      if (value.startsWith(".") ||
                          value.startsWith(",") ||
                          value.startsWith("-")) {
                        return "يُرجى إدخال العمر بطريقة صحيحة";
                      }
                      final age = int.tryParse(value);
                      if (age == null || age > 28 || age < 18) {
                        return "هذا العمر غير صالح";
                      }
                      return null;
                    },
                  ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Customtextfields(
                    hint: "الهدف من التطوع",
                    inputType: TextInputType.multiline,
                    mycontroller: goalController,
                    valid: (value) => value!.isEmpty ? "هذا الحقل مطلوب" : null,
                  ),
                  const SizedBox(height: 10),
                  Customtextfields(
                    hint: "المدينة / الموقع الحالي",
                    inputType: TextInputType.streetAddress,
                    mycontroller: locationController,
                    valid: (value) =>
                        value!.isEmpty ? "الموقع الحالي مطلوب" : null,
                  ),
                  const SizedBox(height: 10),
                  Customtextfields(
                    hint: "عدد الساعات التي ستخصصها للتطوع",
                    inputType: TextInputType.number,
                    mycontroller: hourController,
                    valid: (value) {
                      if (value!.isEmpty) return "عدد الساعات مطلوب";
                      final hours = int.tryParse(value);
                      if (hours == null) return "عدد الساعات مطلوب";
                      if (hours <= 0) return "يجب أن يكون العدد أكبر من صفر";
                      if (hours > 24) return "عدد الساعات لا يجب أن يتجاوز 24";
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Dropdowns
                  RowDropdown(
                    text: 'الجنس:',
                    selectedValue: selectedGender,
                    items: const [
                      DropdownMenuItem(value: 'ذكر', child: Text('ذكر')),
                      DropdownMenuItem(value: 'أنثى', child: Text('أنثى')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  RowDropdown(
                    text: 'المستوى الدراسي:',
                    selectedValue: selectedLevel,
                    items: const [
                      DropdownMenuItem(value: 'ثانوي', child: Text('ثانوي')),
                      DropdownMenuItem(value: 'جامعي', child: Text('جامعي')),
                      DropdownMenuItem(
                          value: 'دراسات عليا', child: Text('دراسات عليا')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLevel = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  Authbutton(
                    buttonText: 'إرسال',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<VoluntaryCubits>(context)
                            .sendVolintaryRequest(
                                phoneController: phoneController,
                                goalController: goalController,
                                locationController: locationController,
                                hourController: hourController,
                                birthDateController: birthDateController,
                                selectedGender: selectedGender,
                                selectedLevel: selectedLevel,
                                selectedDomain: selectedDomain);
                      }
                    },
                    color: colorScheme.primary,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
