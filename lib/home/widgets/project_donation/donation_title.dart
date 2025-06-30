import 'package:flutter/material.dart';

class DonationTitle extends StatelessWidget {
  const DonationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "فرص التبرع",
       style: TextStyle(
        fontSize: 20, 
        fontWeight: FontWeight.bold),
        );
  }
}