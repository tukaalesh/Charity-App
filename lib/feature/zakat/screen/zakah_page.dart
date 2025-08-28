import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/zakat/widgets/zakah/zakah_card.dart';
import 'package:charity_app/feature/zakat/widgets/zakah/zakah_header.dart';
import 'package:flutter/material.dart';

class ZakahPage extends StatefulWidget {
  const ZakahPage({super.key});

  @override
  State<ZakahPage> createState() => _ZakahPageState();
}

class _ZakahPageState extends State<ZakahPage> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
 final colorScheme =context.colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: colorScheme.surface,
        // ignore: prefer_const_constructors
        appBar: ConstAppBar1(
          title: "الزكاة",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
