import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/opportunities/cubit/project_cubit.dart';
import 'package:charity_app/feature/opportunities/cubit/project_state.dart';
import 'package:charity_app/feature/opportunities/widget/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UrgentScreen extends StatefulWidget {
  const UrgentScreen({super.key});

  @override
  State<UrgentScreen> createState() => _UrgentScreenState();
}

class _UrgentScreenState extends State<UrgentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectsCubit>().loadProjectsByType('emergency');
    });
  }

  @override
  Widget build(BuildContext context) {
       final ColorScheme=context.colorScheme;
    return BlocConsumer<ProjectsCubit, ProjectsState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();

        if (state is ProjectsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('حدث خطأ: ${state.message}')),
          );
        } else if (state is ProjectsLoaded) {
        
          if (state.projects.isNotEmpty) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('تم تحميل المشاريع بنجاح')),
            // );
          } 
          // else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     // const SnackBar(content: Text('لا توجد مشاريع حالياً')),
          //   );
          // }
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
           onRefresh: () => context.read<ProjectsCubit>().loadProjectsByType('emergency'),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Builder(
              builder: (_) {
                if (state is ProjectsLoading || state is ProjectsInitial) {
                  return Center(
                  child: SpinKitCircle(size: 45, color: ColorScheme.secondary),
                  );
                } else if (state is ProjectsLoaded) {
                  final projects = state.projects;
          
                  if (projects.isEmpty) {
                    return const Center(child: Text('لا توجد مشاريع حالياً'));
                  }
          
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: projects.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return ProjectCard(project: projects[index]);
                    },
                  );
                } else if (state is ProjectsError) {
                  return Center(child: Text(state.message));
                }
          
                return const SizedBox();
              },
            ),
          ),
        );
      },
    );
  }
}
