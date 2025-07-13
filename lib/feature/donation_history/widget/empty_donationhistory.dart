import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class EmptyDonationHistory extends StatelessWidget {
  const EmptyDonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty.png',
              height: 150,
            ),
            const SizedBox(height: 24),
            Text(
              'سجلك خالٍ من التبرعات حتى الآن',
              style: TextStyle(fontSize: 18,
              color: isDark ? Colors.grey[400] : Colors.black,
               fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'ابدأ رحلتك بالعطاء وأضف أول بصمة خير',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, 
              color: isDark ? Colors.grey[400] :  Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
