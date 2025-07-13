import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  final String ?userName;
  final String message;
  final String date;

  const FeedbackCard({
    super.key,
     this.userName,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
      final isDark = context.isDarkMode;
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 
                MediaQuery.of(context).size.width * 0.90,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color:isDark ? Colors.grey[850] : const Color(0xFFDFF3ED),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اسم المرسل: $userName',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: -11,
                top: 30,
                child: CustomPaint(
                  size: const Size(12, 25),
                  painter: LeftSideTailPainter(
                   color:isDark ? Colors.grey[850]! : const Color(0xFFDFF3ED),
                     ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LeftSideTailPainter extends CustomPainter {
  final Color color;

  LeftSideTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    path.moveTo(size.width, 0); // أعلى يمين
    path.lineTo(0, size.height / 2); // منتصف يسار
    path.lineTo(size.width, size.height); // أسفل يمين
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
