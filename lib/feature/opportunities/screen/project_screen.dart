import 'package:charity_app/feature/opportunities/screen/education_screen.dart';
import 'package:charity_app/feature/opportunities/screen/food_screen.dart';
import 'package:charity_app/feature/opportunities/screen/religion_screen.dart';
import 'package:charity_app/feature/opportunities/screen/health_screen.dart';
import 'package:charity_app/feature/opportunities/screen/residential_screen.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String selectedFilter = 'صحية';

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (selectedFilter) {
      case 'صحية':
        content = const HealthScreen();
        break;
      case 'تعليمية':
        content = const EducationScreen();
        break;
      case 'غذائية':
        content = const FoodScreen();
        break;
      case 'سكنية':
        content = const ResidentialScreen();
        break;
      case 'دينية':
        content = const ReligionScreen();
        break;
      default:
        content = const Center(
            child: Text('واجهة المشاريع',
                style: TextStyle(fontSize: 16, color: Colors.grey)));
    }

    return Column(
      children: [
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              taabss('صحية'),
              const SizedBox(width: 8),
              taabss('تعليمية'),
              const SizedBox(width: 8),
              taabss('غذائية'),
              const SizedBox(width: 8),
              taabss('سكنية'),
              const SizedBox(width: 8),
              taabss('دينية'),
            ],
          ),
        ),
        //const SizedBox(height: 40),
        Expanded(child: content),
      ],
    );
  }

  Widget taabss(String title) {
    final selected = selectedFilter == title;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = title),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFEA926E).withOpacity(0.2)
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            border: selected ? Border.all(color: const Color(0xFFEA926E)) : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected ? const Color(0xFFEA926E) : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
