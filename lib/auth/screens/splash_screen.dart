// splash_screen.dart
import 'package:charity_app/auth/cubits/splash_cubits/splash_cubits.dart';
import 'package:charity_app/auth/cubits/splash_cubits/splash_states.dart';
import 'package:charity_app/auth/screens/welcome_screen.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final colorScheme = context.colorScheme;
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenSize.width / 1.55,
                child: charityLogoImage,
              ),
              Text(
                'منصة وطنية للعمل الخيري',
                style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              SpinKitCircle(size: 43, color: colorScheme.secondary),
              // const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
