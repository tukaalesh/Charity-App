import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/get_volunteer_project_cubit.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/get_volunteer_project_states.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LearningProject extends StatelessWidget {
  const LearningProject({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: const ConstAppBar(title: "تعليمي"),
        body: BlocProvider(
          create: (_) =>
              VolunteerProjectsCubit()..fetchProjectsByType("تعليمي"),
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

                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return ProjectCard(
                      current_amount: project.current_amount ?? 0,
                      description: project.description!,
                      volunteer_hours: project.volunteer_hours,
                      required_tasks: project.required_tasks,
                      name: project.name,
                      total_amount: project.total_amount ?? 0,
                      location: project.location,
                    );
                  },
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
