// ignore_for_file: avoid_types_as_parameter_names

import 'package:charity_app/feature/monthly_donation/cubit/cancle_monthly_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// cubit/cancle_monthly_donation.dart

class CancleMonthlyDonationCubit extends Cubit<CancleMonthlyDonationState> {
  CancleMonthlyDonationCubit() : super(initial());

  void cancleMonthlyDonation() async {
    emit(loading());
    try {
      final token = sharedPreferences.getString('token');

      final response = await Api().put(
        url: "$baseUrl/api/donor/cancelMonthlyDonation",
        token: "$token",
        body: null,
      );
      if (response['message'] == "الميزة غير مفعلة حالياً") {
        emit(alreadyCanceled());
      }
      if (response['message'] == "تم إلغاء التبرع الشهري بنجاح") {
        emit(success());
      }
    } catch (ex) {
      emit(failure());
    }
  }
}
