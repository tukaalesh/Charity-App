import 'package:charity_app/auth/presentation/widgets/auth_button.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/voluntary/helper/pickDate.dart';
import 'package:charity_app/voluntary/presentation/widgets/custom_text_field.dart';
import 'package:charity_app/voluntary/presentation/widgets/row_dropdown.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios),
          backgroundColor: colorScheme.surface,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          title: Text(
            "طلب التطوع",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
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

                GestureDetector(
                  onTap: () {
                    setState(() {});
                    Pickdate().pickDate(context, birthDateController);
                  },
                  child: AbsorbPointer(
                    child: Customtextfields(
                      hint: "اختر تاريخ الميلاد",
                      inputType: TextInputType.none,
                      mycontroller: birthDateController,
                      valid: (_) {
                        if (birthDateController.text.isEmpty) {
                          return "تاريخ الميلاد مطلوب";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
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
                    if (hours == null || hours <= 0)
                      return "أدخل عدد صحيح موجب";
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Dropdowns
                RowDropdown(
                  text: 'الجنس:',
                  selectedValue: selectedGender,
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text('ذكر')),
                    DropdownMenuItem(value: 'female', child: Text('أنثى')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 14),
                RowDropdown(
                  text: 'المستوى الدراسي:',
                  selectedValue: selectedLevel,
                  items: const [
                    DropdownMenuItem(value: 'highschool', child: Text('ثانوي')),
                    DropdownMenuItem(value: 'university', child: Text('جامعي')),
                    DropdownMenuItem(
                        value: 'postgraduate', child: Text('دراسات عليا')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value;
                    });
                  },
                ),
                const SizedBox(height: 14),
                RowDropdown(
                  text: 'مجالات التطوع:',
                  selectedValue: selectedDomain,
                  items: const [
                    DropdownMenuItem(value: 'education', child: Text('تعليمي')),
                    DropdownMenuItem(value: 'health', child: Text('صحي')),
                    DropdownMenuItem(
                        value: 'technology', child: Text("عن بُعد")),
                    DropdownMenuItem(
                        value: 'humanitarian', child: Text("ميداني")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedDomain = value;
                    });
                  },
                ),

                const SizedBox(height: 12),

                Authbutton(
                  buttonText: 'إرسال',
                  onPressed: () {},
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
