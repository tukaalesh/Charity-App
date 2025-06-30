import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/zakat/cubit/zakah_cubit.dart';
import 'package:charity_app/zakat/cubit/zakah_state.dart';
import 'package:charity_app/zakat/widgets/zakah/donationtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZakahCard extends StatelessWidget {
  ZakahCard({super.key});

  final List<int> donationOptions = [100, 200, 400, 500];
  final TextEditingController customAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorSheme = context.colorScheme;
    return BlocConsumer<ZakahCubit, ZakahState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();
        //التحميل
        if (state is ZakahLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('جاري تنفيذ التبرع')),
          );
        } //النجاح وعم نقص الرصيد يلي اتبرع فيه منة المحفظة
        else if (state is ZakahSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'تم التبرع بنجاح! الرصيد الحالي: ${state.newBalance.toStringAsFixed(2)}'),
              backgroundColor: colorSheme.secondary,
            ),
          );
          customAmountController.clear();
        } else if (state is ZakahFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        bool isLoading = state is ZakahLoading;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[50],
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.attach_money, size: 40, color: colorSheme.secondary),
              const SizedBox(height: 8),
              const Text(
                "إخراج زكاة أموال",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                "ادفع مبلغ الزكاة مباشرة",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: donationOptions.map((amount) {
                  return OutlinedButton(
                    onPressed: () {
                      customAmountController.text = amount.toString();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorSheme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundColor: colorSheme.primary,
                    ),
                    child: Text("\$$amount"),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              DonationField(controller: customAmountController),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Authbutton(
                    buttonText: "تبرّع الآن",
                    onPressed: isLoading
                        ? null
                        : () {
                            final amount =
                                double.tryParse(customAmountController.text);
                            if (amount == null || amount <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("يرجى إدخال مبلغ صالح.")),
                              );
                              return;
                            }
                            context.read<ZakahCubit>().donateZakah(amount);
                          },
                    color: colorSheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
