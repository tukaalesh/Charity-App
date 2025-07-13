import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/opportunities/model/project_model.dart';
import 'package:charity_app/home/cubits/donationCubit/modal_cubit.dart';
import 'package:charity_app/home/screens/bottom_sheet.dart';
import 'package:charity_app/home/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final ColorScheme=context.colorScheme;
    final isDark = context.isDarkMode;
    final formatter = NumberFormat("#,###"); // مشان المصاري تنفصل

    final progress = (project.totalAmount != null && project.totalAmount! > 0)
        ? project.currentAmount / project.totalAmount!
        : 0.0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(project: project),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
           color:isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.network(
                    project.photoUrl,
                    width: 150,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress.clamp(0, 1),
                      color: ColorScheme.secondary,
                      backgroundColor: const Color(0xFFc8eada),
                      minHeight: 5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                        style: const TextStyle(
                            fontSize: 14,
                             fontWeight: FontWeight.w600),
                             ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8),
                      decoration: BoxDecoration(
                          color:isDark ? Colors.grey[800] : Colors.grey[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("تم التبرع",
                                  style: TextStyle(
                                      fontSize: 12,
                                       color: ColorScheme.secondary)),
                              const SizedBox(height: 4),
                              Text(
                                '${formatter.format(project.currentAmount)} \$',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:  isDark ? Colors.grey[400] : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("من أصل",
                                  style: TextStyle(
                                      fontSize: 12, 
                                       color: ColorScheme.secondary)),
                              const SizedBox(height: 4),
                              Text(
                                '${formatter.format(project.totalAmount ?? 0)} \$',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                 color:  isDark ? Colors.grey[400] : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (_) => BlocProvider(
                            create: (_) => ModalCubit(),
                            child: DonationBottomSheetContent(project: project),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorScheme.secondary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("تبرع الآن"),
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
