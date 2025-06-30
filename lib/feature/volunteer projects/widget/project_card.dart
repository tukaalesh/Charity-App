// ignore_for_file: non_constant_identifier_names, must_be_immutable
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/volunteer%20request/widgets/buttom.dart';
import 'package:flutter/material.dart';

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
  });

  final String name;
  final int total_amount;
  final String location;
  final String description;
  final String volunteer_hours;
  final String required_tasks;
  final int current_amount;
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
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          "الموقع $location",
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                        const SizedBox(height: 2),
                        // Text(
                        //   "مطلوب $total_amount متطوعين"
                        //   "  تطوع $current_amount",
                        //   style: const TextStyle(
                        //       fontWeight: FontWeight.w300,
                        //       fontSize: 13,
                        //       color: Colors.grey),
                        // ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "مطلوب $total_amount متطوعين  ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              // TextSpan(
                              //   text: "تطوع $current_amount",
                              //   style: const TextStyle(
                              //     fontWeight: FontWeight.w300,
                              //     fontSize: 13,
                              //     color: Colors.grey,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Text(
                          "عدد ساعات التطوع: $volunteer_hours",
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      buttonText: "عرض التفاصيل",
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) {
                            return NewWidget(
                                isDark: isDark,
                                screenWidth: screenWidth,
                                name: name,
                                colorScheme: colorScheme,
                                description: description,
                                required_tasks: required_tasks);
                          },
                        );
                      },
                      color: colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.isDark,
    required this.screenWidth,
    required this.name,
    required this.colorScheme,
    required this.description,
    required this.required_tasks,
  });

  final bool isDark;
  final double screenWidth;
  final String name;
  final ColorScheme colorScheme;
  final String description;
  final String required_tasks;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey[850]
                      : const Color.fromARGB(255, 204, 204, 204),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: colorScheme.secondary
                            // color: colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(description,
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurface,
                          )),
                      const SizedBox(height: 8),
                      Text(
                        "المهام المطلوبة: $required_tasks",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Text(
                      //     "عدد ساعات التطوع: $volunteer_hours"),
                      Button(
                        buttonText: "تطوع الآن",
                        onPressed: () {},
                        color: colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
