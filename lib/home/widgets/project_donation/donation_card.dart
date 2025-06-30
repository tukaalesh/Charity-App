
import 'package:charity_app/home/model/donation_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationCard extends StatelessWidget {
  final projectModel project;

  const DonationCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");

    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: Image.network(project.imageUrl,
                height: 100, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            project.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            // overflow: TextOverflow.ellipsis,
            //تقى هاد منستخدمه وقت يكون الحكي كتير طويل ومابدنا يتغير الحجم
          ),
          const SizedBox(height: 6),
          Text(
            "تم التبرع ${formatter.format(project.donatedAmount)} من اصل ${formatter.format(project.targetAmount)}",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            onPressed: () {
              // showModalBottomSheet(
              //   context: context,
              //   shape: const RoundedRectangleBorder(
              //     borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              //   ),
              //   isScrollControlled: true,
              //   builder: (_) =>  const ModalBottomSheet(),
              // );
            },
            child: const Text("تبرع الآن"),
          )
        ],
      ),
    );
  }
}
