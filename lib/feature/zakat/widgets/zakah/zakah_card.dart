// ignore_for_file: sized_box_for_whitespace
import 'package:charity_app/auth/cubits/user_cubit/user_cubit.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_states.dart';
import 'package:charity_app/auth/widgets/auth_button.dart';
// import 'package:charity_app/constants/const_alert_dilog.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/zakat/cubit/zakah_cubit.dart';
import 'package:charity_app/feature/zakat/cubit/zakah_state.dart';
import 'package:charity_app/home/widgets/project_donation/donation_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZakahCard extends StatelessWidget {
  ZakahCard({super.key});

  final List<int> donationOptions = [100, 200, 400, 500];
  final TextEditingController customAmountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> categories = [
    {'label': 'غذائي', 'icon': Icons.fastfood},
    {'label': 'سكني', 'icon': Icons.home},
    {'label': 'صحي', 'icon': Icons.local_hospital},
    {'label': 'تعليمي', 'icon': Icons.menu_book},
    {'label': 'ديني', 'icon': Icons.volunteer_activism},
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme = context.colorScheme;
    final isDark = context.isDarkMode;

    return BlocConsumer<ZakahCubit, ZakahState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();
        print("الحالة الحالية: $state");

        if (state is ZakahLoading) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('جاري تنفيذ التبرع'),
          //     backgroundColor: Colors.grey,
          //   ),
          // );
        } else if (state is ZakahSuccess) {
          final donatedAmount =double.tryParse(customAmountController.text) ?? 0;

          final userCubit = context.read<UserCubit>();
          if (userCubit.state is UserSuccessState) {
            final user = (userCubit.state as UserSuccessState).user;
            final newBalance = (user.balance - donatedAmount).toInt();
            userCubit.updateBalance(newBalance);
          }

          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) => CustomAlertDialogNoConfirm(
          //     title: 'تم التبرع بنجاح.',
          //     cancelText: "إغلاق",
          //     onCancel: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Center(child: Text('تم التبرع بنجاح')),
              backgroundColor: ColorScheme.secondary,
            ),
          );
          customAmountController.clear();
          formKey.currentState?.reset();
        }
         else if (state is ZakahFailure) {
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) => CustomAlertDialogNoConfirm(
          //     title: state.message,
          //     cancelText: "إغلاق",
          //     onCancel: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // );
          ScaffoldMessenger.of(context).showSnackBar(

            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
        
      },
      
      builder: (context, state) {
        bool isLoading = state is ZakahLoading;
        final cubit = context.read<ZakahCubit>();
        final selectedCategory = cubit.selectedCategory;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Icon(Icons.attach_money,
                    size: 40, color: ColorScheme.secondary),
                const SizedBox(height: 8),
                Text(
                  "إخراج زكاة أموال",
                  style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "ادفع مبلغ الزكاة مباشرة",
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 0,
                  alignment: WrapAlignment.center,
                  children: donationOptions.map((amount) {
                    return SizedBox(
                      width: 80,
                      child: OutlinedButton(
                        onPressed: () {
                          customAmountController.text = amount.toString();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          side: BorderSide(color: ColorScheme.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          foregroundColor: ColorScheme.primary,
                        ),
                        child: Text(
                          "\$$amount",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                DonationField(
                  controller: customAmountController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "الرجاء إدخال مبلغ الزكاة";
                    }
                    final parsedAmount = double.tryParse(value.trim());
                    if (parsedAmount == null) {
                      return "الرجاء إدخال رقم صالح";
                    }
                    if (RegExp(r'^0\d+').hasMatch(value.trim())) {
                      return 'لا يمكن أن يبدأ المبلغ بـ 0';
                    }
                    if (parsedAmount <= 0) {
                      return "يرجى إدخال مبلغ صالح أكبر من 0";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "اختر المجال الذي تُحب أن يذهب خيرك إليه",
                    style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      spacing: 20,
                      runSpacing: 12,
                      children: List.generate(categories.length, (index) {
                        final isSelected =
                            selectedCategory == categories[index]['label'];
                        return GestureDetector(
                          onTap: () {
                            cubit.selectCategory(categories[index]['label']);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: isSelected
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey[700]
                                        : Colors.grey[400],

                                // isSelected? ColorScheme.secondary: Colors.grey[400],
                                child: Icon(
                                  categories[index]['icon'],
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                categories[index]['label'],
                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      isDark ? Colors.grey[400] : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 500,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Authbutton(
                      buttonText: "تبرّع الآن",
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                if (selectedCategory == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('يرجى اختيار المجال أولاً')),
                                  );
                                  return;
                                }
                                final amount = double.parse(
                                    customAmountController.text.trim());
                                cubit.donateZakah(amount, selectedCategory);
                              }
                            },
                      color: ColorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
