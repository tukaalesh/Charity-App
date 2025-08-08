import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/feature/volunteer_form/cubit_request/voluntary_cubits.dart';
import 'package:charity_app/feature/volunteer_form/cubit_request/voluntary_states.dart';
import 'package:charity_app/feature/volunteer_form/widget/form_page_one.dart';
import 'package:charity_app/feature/volunteer_form/widget/form_page_two.dart';
import 'package:flutter/material.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController fieldOfStudyController = TextEditingController();
  final TextEditingController hoursCountController = TextEditingController();
  final TextEditingController volunteerGoalController = TextEditingController();

  String gender = "";
  String study = "";
  int currentPage = 0;

  void nextPage() {
    if (_formKey.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => currentPage--);
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (gender.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("الرجاء اختيار الجنس")),
        );
        return;
      }
      if (study.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("الرجاء اختيار المؤهل الدراسي")),
        );
        return;
      }

      final cubit = context.read<VoluntaryCubits>();
      cubit.sendVolintaryRequest(
          phoneController: phoneController,
          locationController: locationController,
          study: study,
          birthDateController: birthDateController,
          gender: gender,
          fieldOfStudyController: fieldOfStudyController,
          hoursCountController: hoursCountController,
          volunteerGoalController: volunteerGoalController);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return BlocConsumer<VoluntaryCubits, VoluntaryState>(
      listener: (context, state) {
        if (state is VolunteeringSubmittedSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title:
                  " تم إرسال استبيان التطوّع بنجاح. سيصلك قريباً إشعار بخصوص حالة طلبك.",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'NavigationMain');
              },
            ),
          );
        } else if (state is VolunteeringSubmittedAlredySend) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title:
                  "لقد قمت بالتسجيل على استبيان التطوع مسبقًا ولا يمكنك التسجيل مرة أخرى.",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'NavigationMain');
              },
            ),
          );
        } else if (state is PhoneNumberAlredyUsed) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title: "رقم الهاتف مستخدم بالفعل من قبل مستخدم آخر",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
          );
        } else if (state is VolunteeringSubmittedFailure) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialogNoConfirm(
              title: "حصل خطأ يُرجى المحاولة لاحقاً !",
              cancelText: "إغلاق",
              onCancel: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Scaffold(
                appBar: const ConstAppBar(title: "طلب التطوع"),
                backgroundColor: context.colorScheme.surface,
                body: Form(
                  key: _formKey,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FormPageOne(
                        phoneController: phoneController,
                        birthDateController: birthDateController,
                        locationController: locationController,
                        gender: gender,
                        onGenderChanged: (val) => setState(() => gender = val),
                        onNext: nextPage,
                        colorScheme: context.colorScheme,
                      ),
                      FormPageTwo(
                        onPrevious: previousPage,
                        onSubmit: submitForm,
                        colorScheme: context.colorScheme,
                        fieldOfStudyController: fieldOfStudyController,
                        volunteerGoalController: volunteerGoalController,
                        hoursCountController: hoursCountController,
                        study: study,
                        onStudyChanged: (value) =>
                            setState(() => study = value),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is VolunteeringSubmittedLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: SpinKitCircle(
                      color: colorScheme.secondary,
                      size: 50,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
