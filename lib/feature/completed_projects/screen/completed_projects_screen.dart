import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/completed_projects/cubit/completed_projects_cubit.dart';
import 'package:charity_app/feature/completed_projects/cubit/completed_projects_states.dart';
import 'package:charity_app/feature/completed_projects/widget/completed_project_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CompletedProjectsScreen extends StatelessWidget {
  const CompletedProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorscheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorscheme.surface,
        appBar: const ConstAppBar(title: 'المشاريع المنجزة'),
        body: BlocProvider(
          create: (context) =>
              CompletedProjectsCubit()..fetchCompletedProject(),
          child: BlocBuilder<CompletedProjectsCubit, CompletedProjectsStates>(
            builder: (context, state) {
              if (state is CompletedProjectsLoading) {
                return Center(
                  child: SpinKitCircle(
                    color: colorscheme.primary,
                    size: 45,
                  ),
                );
              } else if (state is CompletedProjectsSuccess) {
                final cubit = context.read<CompletedProjectsCubit>();
                return RefreshIndicator(
                  onRefresh: () async {
                    await cubit.fetchCompletedProject();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: cubit.completedProjects.length,
                    itemBuilder: (context, index) {
                      final project = cubit.completedProjects[index];
                      return CompletedProjectBox(project: project);
                    },
                  ),
                );
              } else if (state is CompletedProjectsError) {
                return Center(child: Text('خطأ: ${state.message}'));
              } else {
                return const Center(child: Text("هناك خطأ في جلب البيانات"));
              }
            },
          ),
        ),
      ),
    );
  }
}
