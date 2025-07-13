import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/completed_projects/model/completed_projects_model.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CompletedProjectBox extends StatelessWidget {
  final CompletedProjectsModel project;

  const CompletedProjectBox({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size;
    final isDark = context.isDarkMode;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.grey[850]
              : const Color.fromARGB(255, 250, 251, 252),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: screenWidth.width * 0.35,
                  height: screenWidth.height * 0.30,
                  child: project.photo_url.isNotEmpty
                      ? Image.network(
                          project.photo_url,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey,
                            );
                          },
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تم بحمد اللّه إنجاز مشروع ${project.name.isNotEmpty ? project.name : 'عنوان غير متوفر'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReadMoreText(
                      project.description.isNotEmpty
                          ? project.description
                          : 'لا يوجد وصف للمشروع.',
                      trimLines: 6,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'عرض المزيد',
                      trimExpandedText: 'عرض أقل',
                      moreStyle: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                      lessStyle: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                      ),
                      // textAlign: TextAlign.justify,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
