// ignore_for_file: avoid_types_as_parameter_names

import 'package:charity_app/feature/monthly_donation/cubit/monthly_donation_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthlyDonationCubit extends Cubit<MonthlyDonationStates> {
  MonthlyDonationCubit() : super(initialState());
  void enableMonthlyDonation({required moneyController}) async {
    emit(loadingStates());
    try {
      final response = await Api().post(
          url: "http://$localhost/api/donor/monthlyDonation",
          body: {"amount": moneyController.text},
          token: "$token");
      if (response['message'] == "تم تعديل مبلغ التبرع الشهري بنجاح") {
        emit(editStates());
      }
      if (response['message'] == "تم تفعيل التبرع الشهري بنجاح") {
        emit(successStates());
      }
    } catch (ex) {
      emit(failureStates());
    }
  }
}
