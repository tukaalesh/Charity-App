import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/screens/navigation_main.dart';
import 'package:charity_app/home/widgets/initial_circle.dart';
import 'package:charity_app/main.dart';
import 'package:flutter/material.dart';

class NotifictionPage extends StatelessWidget {
  const NotifictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = sharedPreferences.getString('userName') ?? "?";
    final isDark = context.isDarkMode;
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leadingWidth: 80,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const NavigationMain()),
                (route) => false,
              );
            },
          ),
          title: const Text(
            "الإشعارات",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 4),
              child: Initialcircle(
                text: userName.substring(0, 1).toUpperCase(),
              ),
            ),
          ],
        ),
        backgroundColor: colorScheme.surface,
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 9, // قللنا العدد لأن حذفنا أول عنصر
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? const Color.fromARGB(255, 67, 67, 67)
                          : const Color.fromARGB(255, 193, 193, 193),
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'تم استلام تبرعك بنجاح',
                              style: TextStyle(
                                color: colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'الآن',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'شكراً لك! تم استلام تبرعك لمشروع (اسم المشروع). جزاك الله خيراً 🙏🏼',
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
