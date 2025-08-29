import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

abstract class DonationButtonState {}

class DonationButtonInitial extends DonationButtonState {}

class DonationButtonLoading extends DonationButtonState {}

class DonationButtonSuccess extends DonationButtonState {}

class BalanceNotEnough extends DonationButtonState {}

class DonationButtonFailure extends DonationButtonState {
  final String message;
  DonationButtonFailure(this.message);
}

class DonationAmountMoreThanTotal extends DonationButtonState {
  final int remainingAmount;
  DonationAmountMoreThanTotal(this.remainingAmount);
}

//cubit
class DonationButtonCubit extends Cubit<DonationButtonState> {
  DonationButtonCubit() : super(DonationButtonInitial());

  Future<void> donateToProject({
    required int projectId,
    required int amount,
    required int totalAmount,
    required int currentAmount,
  }) async {
    emit(DonationButtonLoading());

    final remainingAmount = totalAmount - currentAmount;
    if (amount > remainingAmount) {
      emit(DonationAmountMoreThanTotal(remainingAmount));
      return;
    }

    try {
      final token = sharedPreferences.get("token");

      final response = await Api().post(
        url: "$baseUrl/api/donor/donateToProject/?id=$projectId&amount=$amount",
        token: "$token",
        body: {},
      );
      print("Donation response: $response");

      if (response['message'] != null &&
          response['message'].toString().contains("أكبر من المبلغ المتبقي")) {
        emit(DonationAmountMoreThanTotal(remainingAmount));
        return;
      }
      emit(DonationButtonSuccess());
    } catch (e) {
      print('ERROR CONTENT: ${e.toString()}');

      final errorString = e.toString();

      final match = RegExp(r'message: (.*?)\}').firstMatch(errorString);
      final message = match?.group(1);

      if (message != null) {
        if (message ==
            "ليس لديك رصيد كافٍ لإتمام هذه العملية، الرجاء شحن المحفظة وإعادة المحاولة.") {
          emit(BalanceNotEnough());
          return;
        }
      }

      emit(DonationButtonFailure("فشل التبرع: $e"));
    }
  }
}
