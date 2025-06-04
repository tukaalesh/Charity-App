import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
      ),
      backgroundColor: colorScheme.surface,
      drawer: const SettingDrawer(),
    );
  }
}
