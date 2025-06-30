
import 'package:charity_app/home/widgets/bottom_sheet/donate_button.dart';
import 'package:charity_app/home/widgets/bottom_sheet/donate_field.dart';
import 'package:charity_app/home/widgets/bottom_sheet/donation_option.dart';
import 'package:charity_app/home/widgets/bottom_sheet/handle_bottom.dart';
import 'package:charity_app/home/widgets/bottom_sheet/title_bottom.dart';
import 'package:flutter/material.dart';

class DonationBottomSheetContent extends StatefulWidget {
  const DonationBottomSheetContent({super.key});

  @override
  State<DonationBottomSheetContent> createState() =>
      _DonationBottomSheetContentState();
}

class _DonationBottomSheetContentState extends State<DonationBottomSheetContent> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HandleBottom(),
                    const SizedBox(height: 25),
                    const TitleBottom(),
                    const SizedBox(height: 25),
                    DonationOptions(),
                    const SizedBox(height: 25),
                    const DonateField(),
                    const SizedBox(height: 45),
                    DonateButton(formKey: formKey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}