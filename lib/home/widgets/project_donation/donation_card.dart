import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/cubits/donationCubit/modal_cubit.dart';
import 'package:charity_app/home/model/donation_model.dart';
import 'package:charity_app/home/screens/bottom_sheet.dart';
import 'package:charity_app/home/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DonationCard extends StatelessWidget {
  final DonationModel project;

  const DonationCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
      
    final isDark = context.isDarkMode;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(project: project.toProjectModel()),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                project.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image,
                      size: 150,
                      color: Colors.grey[400],
                    ),),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(right: 5, top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style:  TextStyle(
                      color:  isDark ? Colors.grey[400] : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'تم التبرع: ${formatter.format(project.currentAmount)} \$',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
               height: 34,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => BlocProvider(
                      create: (_) => ModalCubit(),
                      child: DonationBottomSheetContent(
                        project: project.toProjectModel(),
                      ),
                    ),
                  );
                },
                child: const Text("تبرع الآن"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
