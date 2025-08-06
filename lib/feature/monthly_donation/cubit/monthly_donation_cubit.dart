// ignore_for_file: avoid_types_as_parameter_names

import 'package:charity_app/feature/monthly_donation/cubit/monthly_donation_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthlyDonationCubit extends Cubit<MonthlyDonationStates> {
  MonthlyDonationCubit() : super(MpthlyDonationinitial());
  void enableMonthlyDonation({
    required moneyController,
    required String? selectedCategory,
  }) async {
    emit(MothlyDonationLoading());
    try {
      final token = sharedPreferences.getString('token');

      final response = await Api().post(
          url: "$baseUrl/api/donor/monthlyDonation",
          body: {
            "amount": moneyController.text,
            "type": selectedCategory ?? "",
          },
          token: "$token");
      print(response);

      emit(MothlyDonationSuccess());
      // }
    } catch (ex) {
      print('ERROR CONTENT: ${ex.toString()}');

      final errorString = ex.toString();

      final match = RegExp(r'message: (.*?)\}').firstMatch(errorString);
      final message = match?.group(1);

      if (message != null) {
        if (message ==
            "إن هذه الميزة مفعلة لديك سابقاً، إذا كنت تريد تعديل المبلغ أو نوع التبرع، يمكنك إلغاء الميزة أولاً ثم إعادة تفعيلها من جديد") {
          emit(MonthlyDonationUpdateFailed());
          return;
        }
      }
      emit(MothlyDonationFailure());
    }
  }
}
