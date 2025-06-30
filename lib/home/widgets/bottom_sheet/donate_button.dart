// import 'package:charity_app/constants/color.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/cubits/donationCubit/modal_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const DonateButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
        final colorScheme = context.colorScheme;

    return BlocBuilder<ModalCubit, String>(
      builder: (context, selectedAmount) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تمت الإضافة إلى المشاريع المحفوظة'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(140, 40),
              ),
              child: const Text(
                "إضافة إلى المشاريع المحفوظة",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تبرعت بمبلغ: $selectedAmount'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(180, 40),
              ),
              child: const Text(
                "تبرّع الآن",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }
}
