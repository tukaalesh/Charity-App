import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/opportunities/model/project_model.dart';
import 'package:charity_app/home/widgets/bottom_sheet/donate_button.dart';
import 'package:charity_app/home/widgets/bottom_sheet/donate_field.dart';
import 'package:charity_app/home/widgets/bottom_sheet/donation_option.dart';
import 'package:charity_app/home/widgets/bottom_sheet/handle_bottom.dart';
import 'package:charity_app/home/widgets/bottom_sheet/title_bottom.dart';
import 'package:flutter/material.dart';

class DonationBottomSheetContent extends StatefulWidget {
  const DonationBottomSheetContent({super.key,required this.project});
final ProjectModel project;
  @override
  State<DonationBottomSheetContent> createState() =>
      _DonationBottomSheetContentState();
}

class _DonationBottomSheetContentState extends State<DonationBottomSheetContent> {
  final formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    
      final isDark = context.isDarkMode;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color:isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
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
                  DonateButton(formKey: formKey, project: widget.project),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
