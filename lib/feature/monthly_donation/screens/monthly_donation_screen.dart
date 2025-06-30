import 'package:charity_app/auth/widgets/auth_button.dart';
import 'package:charity_app/constants/const_appBar.dart';
import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:charity_app/feature/monthly_donation/cubit/cancle_monthly_donation.dart';
import 'package:charity_app/feature/monthly_donation/cubit/cancle_monthly_states.dart';
import 'package:charity_app/feature/monthly_donation/widget/botton_monthly_donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MonthlyDonationScreen extends StatelessWidget {
  const MonthlyDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child:
          BlocConsumer<CancleMonthlyDonationCubit, CancleMonthlyDonationState>(
        listener: (context, state) {
          if (state is success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إلغاء التبرع الشهري بنجاح ')),
            );
          } else if (state is alreadyCanceled) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("الميزة غير مفعلة حالياً")),
            );
          } else if (state is failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('هناك خطأ ما يُرجى المحاولة فيما بعد')),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: const ConstAppBar(title: "التبرع الشهري"),
            backgroundColor: colorScheme.surface,
            body: Column(
              children: [
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 16, bottom: 8),
                  child: Text(
                    "هل ترغب بأن تكون سببًا في استمرارية الخير؟ يمكنك التبرع بالمبلغ الذي تختاره لدعم المشاريع الخيرية والمساهمة في إحداث فرق",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Authbutton(
                      buttonText: "تفعيل",
                      onPressed: () {
                        Navigator.pushNamed(context, 'EnableMonthlyOnation');
                      },
                      color: colorScheme.secondary),
                ),

                // BottonMonthlyDonation(
                //   onPressed: () {
                //     Navigator.pushNamed(context, 'EnableMonthlyOnation');
                //   },
                //   text: "تفعيل",
                // ),
                const SizedBox(height: 14),
                if (state is loading)
                  SpinKitCircle(
                    color: colorScheme.secondary,
                    size: 45,
                  )
                else
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Authbutton(
                        buttonText: "إلغاء التفعيل",
                        onPressed: () {
                          context
                              .read<CancleMonthlyDonationCubit>()
                              .cancleMonthlyDonation();
                        },
                        color: colorScheme.primary,
                      )),
                // BottonMonthlyDonation(
                //   onPressed: () {
                //     context
                //         .read<CancleMonthlyDonationCubit>()
                //         .cancleMonthlyDonation();
                //   },
                //   text: "إلغاء التفعيل",
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
