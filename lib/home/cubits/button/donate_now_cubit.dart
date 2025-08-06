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

class DonationButtonCubit extends Cubit<DonationButtonState> {
  DonationButtonCubit() : super(DonationButtonInitial());

  Future<void> donateToProject(
      {required int projectId, required int amount}) async {
    emit(DonationButtonLoading());

    try {
      final token = sharedPreferences.get("token");

      final response = await Api().post(
        url: "$baseUrl/api/donor/donateToProject/?id=$projectId&amount=$amount",
        token: "$token",
        body: {},
      );

// "ليس لديك رصيد كافٍ لإتمام هذه العملية، الرجاء شحن المحفظة وإعادة المحاولة."

      print("Donation response: $response");

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
