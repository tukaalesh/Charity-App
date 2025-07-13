// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/custom_text.dart';

class FormPageTwo extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;
  final ColorScheme colorScheme;
  final TextEditingController fieldOfStudyController;
  final TextEditingController hoursCountController;
  final TextEditingController volunteerGoalController;
  final String study;
  final ValueChanged<String> onStudyChanged;

  const FormPageTwo({
    super.key,
    required this.onPrevious,
    required this.onSubmit,
    required this.colorScheme,
    required this.fieldOfStudyController,
    required this.hoursCountController,
    required this.volunteerGoalController,
    required this.study,
    required this.onStudyChanged,
  });

  @override
  State<FormPageTwo> createState() => _FormPageTwoState();
}

class _FormPageTwoState extends State<FormPageTwo> {
  final _formKey = GlobalKey<FormState>();
  String selectedStudy = "";

  final List<String> studyOptions = [
    "طالب جامعي",
    "بكالوريوس",
    "ماجستير",
  ];

  @override
  void initState() {
    super.initState();
    selectedStudy = widget.study;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("آخر مؤهل دراسي وصلت له؟"),
                    ),
                    ...studyOptions.map(
                      (option) => CheckboxListTile(
                        side: const BorderSide(color: Colors.grey, width: 1),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        title: Text(
                          option,
                          style: const TextStyle(fontSize: 14),
                        ),
                        value: selectedStudy == option,
                        onChanged: (checked) {
                          setState(() {
                            selectedStudy = checked! ? option : "";
                            widget.onStudyChanged(selectedStudy);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                      ),
                    ),
                    if (selectedStudy.isEmpty)
                      const Text(
                        "يرجى اختيار المؤهل الدراسي",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("مجال الدراسة / التخصص"),
                    ),
                    const SizedBox(height: 10),
                    Customtextfields(
                      hint: "مثلاً: هندسة معلوماتية",
                      inputType: TextInputType.text,
                      mycontroller: widget.fieldOfStudyController,
                      valid: (value) =>
                          value!.isEmpty ? "هذا الحقل مطلوب" : null,
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("عدد ساعات التطوع"),
                    ),
                    const SizedBox(height: 10),
                    Customtextfields(
                      hint: "مثلاً: 2",
                      inputType: TextInputType.number,
                      mycontroller: widget.hoursCountController,
                      valid: (value) {
                        if (value!.isEmpty) return "هذا الحقل مطلوب";
                        final num = int.tryParse(value);
                        if (num == null || num <= 0 || num > 24)
                          return "أدخل عدد صالح بين 1 و 24";
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text("ما الهدف من التطوع؟"),
                    ),
                    const SizedBox(height: 10),
                    Customtextfields(
                      hint: "مثلاً: اكتساب خبرة أو خدمة المجتمع...",
                      inputType: TextInputType.multiline,
                      mycontroller: widget.volunteerGoalController,
                      valid: (value) =>
                          value!.isEmpty ? "هذا الحقل مطلوب" : null,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: Authbutton(
                            buttonText: "السابق",
                            onPressed: widget.onPrevious,
                            color: widget.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Authbutton(
                            buttonText: "إرسال",
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  selectedStudy.isNotEmpty) {
                                widget.onSubmit();
                              } else {
                                setState(() {});
                              }
                            },
                            color: widget.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
