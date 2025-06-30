import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/zakat/widgets/zakah/zakah_card.dart';
import 'package:charity_app/zakat/widgets/zakah/zakah_header.dart';
import 'package:flutter/material.dart';

class ZakahPage extends StatefulWidget {
  const ZakahPage({super.key});

  @override
  State<ZakahPage> createState() => _ZakahPageState();
}

class _ZakahPageState extends State<ZakahPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const ZakahHeader(),
              const SizedBox(height: 24),
              ZakahCard(),
            ],
          ),
        ),
      ),
    );
  }
}
