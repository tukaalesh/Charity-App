// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/custom_text.dart';

class FormPageOne extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController birthDateController;
  final TextEditingController locationController;
  final String gender;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onNext;
  final ColorScheme colorScheme;

  const FormPageOne({
    super.key,
    required this.phoneController,
    required this.birthDateController,
    required this.locationController,
    required this.gender,
    required this.onGenderChanged,
    required this.onNext,
    required this.colorScheme,
  });

  @override
  State<FormPageOne> createState() => _FormPageOneState();
}

class _FormPageOneState extends State<FormPageOne> {
  final _formKey = GlobalKey<FormState>();
  bool showGenderError = false;

  void _handleNext() {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (widget.gender.isEmpty) {
      setState(() => showGenderError = true);
    } else {
      setState(() => showGenderError = false);
    }

    if (isFormValid && widget.gender.isNotEmpty) {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text("رقم التواصل"),
                ),
                const SizedBox(height: 10),
                Customtextfields(
                  hint: "رقم للتواصل",
                  inputType: TextInputType.phone,
                  mycontroller: widget.phoneController,
                  valid: (value) {
                    if (value!.isEmpty) return "رقم الهاتف مطلوب";
                    if (value.length != 10)
                      return "رقم الهاتف يجب أن يكون 10 أرقام";
                    if (!value.startsWith("09"))
                      return "يجب أن يبدأ الرقم بـ 09";
                    if (value.contains(".") ||
                        value.contains(",") ||
                        value.contains("-")) return "أدخل الرقم بشكل صحيح";
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text("العمر"),
                ),
                const SizedBox(height: 10),
                Customtextfields(
                  hint: "العمر",
                  inputType: TextInputType.number,
                  mycontroller: widget.birthDateController,
                  valid: (value) {
                    if (value!.isEmpty) return "العمر مطلوب";
                    final age = int.tryParse(value);
                    if (age == null || age < 19 || age > 28)
                      return "العمر غير صالح";
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text("مكان السكن"),
                ),
                const SizedBox(height: 10),
                Customtextfields(
                  hint: "مثلاً: دمشق، حلب ...",
                  inputType: TextInputType.streetAddress,
                  mycontroller: widget.locationController,
                  valid: (value) =>
                      value!.isEmpty ? "الموقع الحالي مطلوب" : null,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text("الجنس"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        side: const BorderSide(color: Colors.grey, width: 1),
                        title: const Text(
                          "أنثى",
                          style: TextStyle(fontSize: 14),
                        ),
                        value: widget.gender == "أنثى",
                        onChanged: (checked) {
                          widget.onGenderChanged(checked == true ? "أنثى" : "");
                          if (showGenderError) setState(() {});
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        side: const BorderSide(color: Colors.grey, width: 1),
                        title: const Text(
                          "ذكر",
                          style: TextStyle(fontSize: 14),
                        ),
                        value: widget.gender == "ذكر",
                        onChanged: (checked) {
                          widget.onGenderChanged(checked == true ? "ذكر" : "");
                          if (showGenderError) setState(() {});
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
                if (showGenderError && widget.gender.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "يرجى اختيار الجنس",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 20),
                Authbutton(
                  buttonText: 'التالي',
                  onPressed: _handleNext,
                  color: widget.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
