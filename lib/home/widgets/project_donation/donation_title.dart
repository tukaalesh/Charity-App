import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/opportunities/screen/opportunities_screen.dart';
import 'package:flutter/material.dart';

class DonationTitle extends StatelessWidget {
  const DonationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          " المشاريع السارية",
          style: TextStyle(
              fontSize: 20,
              color: isDark ? Colors.grey[400] : Colors.black,
              fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OpportunitiesScreen()),
            );
          },
          child: Text(
            'عرض المزيد',
            style: TextStyle(
          
               color: isDark ? Colors.grey[400] : Colors.grey[800],
              //  decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
