import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/const_image.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              width: double.infinity,
              height: size.height / 1.9,
              child: welcomeImage),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Authbutton(
                    buttonText: 'إنشاء حساب',
                    onPressed: () {
                      Navigator.pushNamed(context, 'SignUp');
                    },
                    color: colorScheme.secondary),
                const SizedBox(
                  height: 15,
                ),
                Authbutton(
                    buttonText: 'تسجيل دخول',
                    onPressed: () {
                      Navigator.pushNamed(context, 'LogIn');
                    },
                    color: colorScheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
