// ignore_for_file: non_constant_identifier_names

import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/join_to_project/join_to_project_cubit.dart';
import 'package:charity_app/feature/volunteer%20projects/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.name,
    required this.total_amount,
    required this.location,
    required this.description,
    required this.volunteer_hours,
    required this.required_tasks,
    required this.current_amount,
    required this.id,
  });

  final String name;
  final int total_amount;
  final String location;
  final String description;
  final String volunteer_hours;
  final String required_tasks;
  final int current_amount;
  final int id;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 46, 46, 46).withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: screenWidth * 0.24,
                      height: screenWidth * 0.24,
                      child: charityLogoImage,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 15, color: colorScheme.secondary),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                location,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.group_outlined,
                                size: 15, color: colorScheme.secondary),
                            const SizedBox(width: 4),
                            Text(
                              "مطلوب $total_amount متطوعين",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 15, color: colorScheme.secondary),
                            const SizedBox(width: 4),
                            Text(
                              "عدد ساعات التطوع: $volunteer_hours",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.task_outlined,
                                size: 15, color: colorScheme.secondary),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "المهام المطلوبة: $required_tasks",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        VolunterButton(
                          buttonText: "تطوع الآن",
                          onPressed: () {
                            context
                                .read<JoinToProjectCubit>()
                                .joinToProject(id: id);
                          },
                          color: colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
