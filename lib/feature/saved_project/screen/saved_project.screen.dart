import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/core/extensions/widget_extentions.dart';
import 'package:charity_app/home/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/feature/opportunities/widget/project_card.dart';
import 'package:charity_app/feature/saved_project/cubit/saved_project_cubit.dart';
import 'package:charity_app/feature/saved_project/cubit/saved_project_state.dart';
import 'package:charity_app/feature/saved_project/widget/search.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SavedProjectsScreen extends StatefulWidget {
  const SavedProjectsScreen({super.key});

  @override
  State<SavedProjectsScreen> createState() => _SavedProjectsScreenState();
}

class _SavedProjectsScreenState extends State<SavedProjectsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SavedProjectsCubit>().fetchSavedProjects();

    searchController.addListener(() {
      final query = searchController.text.trim();
      context.read<SavedProjectsCubit>().fetchSavedProjects(query: query);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void confirmDelete(int projectId) {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا المشروع؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(_).pop(),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () async {
                await context
                    .read<SavedProjectsCubit>()
                    .removeSavedProject(projectId);
                Navigator.of(_).pop();
              },
              child: const Text('حذف'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return RefreshIndicator(
      onRefresh: () => context.read<SavedProjectsCubit>().fetchSavedProjects(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: colorScheme.surface,
        appBar: const ConstAppBar(title: 'المشاريع المحفوظة'),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                search(
                  controller: searchController,
                  onSearchChanged: (query) {
                    context
                        .read<SavedProjectsCubit>()
                        .fetchSavedProjects(query: query);
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<SavedProjectsCubit, SavedProjectsState>(
                    builder: (context, state) {
                      if (state is SavedProjectsLoading) {
                        return Center(
                          child: SpinKitCircle(
                              size: 45, color: colorScheme.secondary),
                        );
                      } else if (state is SavedProjectsLoaded) {
                        if (state.projects.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.inbox,
                                    size: 120, color: Colors.grey[300]),
                                const SizedBox(height: 20),
                                const Text(
                                  'لا توجد مشاريع محفوظة',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }
                        return AnimationLimiter(
                          child: ListView.separated(
                            itemCount: state.projects.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final project = state.projects[index];
                              return GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            DetailsScreen(project: project)),
                                  );
                                  if (result == true) {
                                    context
                                        .read<SavedProjectsCubit>()
                                        .fetchSavedProjects();
                                  }
                                },
                                child: Stack(
                                  children: [
                                    ProjectCard(project: project),
                                    Positioned(
                                      top: 1,
                                      left: -3,
                                      child: IconButton(
                                        icon: const Icon(Icons.close,
                                            color: Colors.black),
                                        onPressed: () =>
                                            confirmDelete(project.id),
                                      ),
                                    ),
                                  ],
                                ).staggerListVertical(index),
                              );
                            },
                          ),
                        );
                      } else if (state is SavedProjectsError) {
                        return Center(
                          child: Text(
                            'حدث خطأ: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
