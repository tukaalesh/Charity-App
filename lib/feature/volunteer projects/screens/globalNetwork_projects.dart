// ignore_for_file: file_names
import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/get_volunteer/get_volunteer_project_cubit.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/get_volunteer/get_volunteer_project_states.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/join_to_project/join_to_project_cubit.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/join_to_project/join_to_project_states.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GlobalnetworkProjects extends StatelessWidget {
  const GlobalnetworkProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: const ConstAppBar(title: "عن بُعد"),
        body: BlocProvider(
          create: (_) =>
              VolunteerProjectsCubit()..fetchProjectsByType("عن بُعد"),
          child: BlocBuilder<VolunteerProjectsCubit, VolunteerProjectsState>(
            builder: (context, state) {
              if (state is VolunteerProjectsLoading) {
                return Center(
                  child: SpinKitCircle(
                    color: colorScheme.primary,
                    size: 45,
                  ),
                );
              } else if (state is VolunteerProjectsError) {
                return Center(child: Text("صار خطأ: ${state.message}"));
              } else if (state is VolunteerProjectsSuccess) {
                final projects = state.projects;

                if (projects.isEmpty) {
                  return const Center(child: Text("لا يوجد مشاريع حالياً"));
                }

                return BlocListener<JoinToProjectCubit, JoinToProjectStates>(
                  listener: (context, state) {
                    if (state is JoinToProjectSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text("تم إرسال طلب التطوع بنجاح!")),
                      );
                    } else if (state is JoinToProjectNoSurvey) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => CustomAlertDialog(
                          title: "مطلوب تعبئة استبيان التطوع",
                          content:
                              "يرجى تعبئة استبيان التطوع قبل الانضمام للمشاريع.",
                          confirmText: "فتح الاستبيان",
                          cancelText: "إلغاء",
                          onConfirm: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, 'VolunteerForm');
                          },
                          onCancel: () => Navigator.of(context).pop(),
                        ),
                      );
                    } else if (state is JoinToProjectAlreadyApplied) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text(
                                "عذراً، لا يمكن الانضمام لهذا المشروع حالياً بسبب تطوعك في مشروع آخر.")),
                      );
                    } else if (state is JoinToProjectPendingApproval) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text(
                                "لا يزال طلب التطوع خاصتك قيد الدراسة، يمكنك البدء بالتطوع عندما يتم قبول طلبك")),
                      );
                    } else if (state is JoinToProjectBlocked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text(
                                "تم إيقاف تطوعك في الجمعية بسبب مخالفات في تنفيذ المهام التطوعية، لمتابعة التفاصيل أو الاعتراض، يُرجى التواصل مع إدارة التطبيق على صفحة الفيسبوك الخاصة بالجمعية")),
                      );
                    } else if (state is JoinToProjectRejected) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text(
                                " تم رفض طلب تطوعك في الجمعية لأسباب متعلقة بسياسة الجمعية، لمتابعة التفاصيل أو الاعتراض، يُرجى التواصل مع إدارة التطبيق على صفحة الفيسبوك الخاصة بالجمعية")),
                      );
                    } else if (state is JoinToProjectFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            duration: Duration(seconds: 4),
                            content: Text("حدث خطأ، حاول لاحقاً.")),
                      );
                    }
                  },
                  child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return ProjectCard(
                        id: project.id,
                        current_amount: project.current_amount ?? 0,
                        description: project.description!,
                        volunteer_hours: project.volunteer_hours,
                        required_tasks: project.required_tasks,
                        name: project.name,
                        total_amount: project.total_amount ?? 0,
                        location: project.location,
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text("ما في بيانات"));
              }
            },
          ),
        ),
      ),
    );
  }
}
