import 'package:flutter/material.dart';

class HandleBottom extends StatelessWidget {
  const HandleBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}