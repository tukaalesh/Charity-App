import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/home/cubits/donationCubit/modal_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonateField extends StatefulWidget {
  const DonateField({super.key});

  @override
  State<DonateField> createState() => _DonateFieldState();
}

class _DonateFieldState extends State<DonateField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ModalCubit>();
    controller = TextEditingController(text: cubit.state);

    cubit.stream.listen((selectedAmount) {
      if (controller.text != selectedAmount) {
        controller.text = selectedAmount;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final ColorScheme=context.colorScheme;
      final isDark = context.isDarkMode;
    final cubit = context.read<ModalCubit>();

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: "مبلغ التبرع",
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            Icons.attach_money,
            color: ColorScheme.secondary,
            size: 24,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Colors.grey), // لون البوردر العادي
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Colors.grey), // البوردر مو شغال
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: Colors.grey, width: 1.4), // البوردر شغال   
        ),
         fillColor:  isDark ? Colors.grey[850] :  Colors.grey[100],
      ),
      
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'يرجى إدخال المبلغ';
        }
        if (double.tryParse(value) == null) {
          return 'يرجى إدخال رقم صالح';
        }
        return null;
      },
      onChanged: (value) {
        cubit.selectAmount(value);
      },
      
    );
  }
}
