import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

abstract class DonationButtonState {}

class DonationButtonInitial extends DonationButtonState {}

class DonationButtonLoading extends DonationButtonState {}

class DonationButtonSuccess extends DonationButtonState {}

class DonationButtonFailure extends DonationButtonState {
  final String message;
  DonationButtonFailure(this.message);
}

class DonationButtonCubit extends Cubit<DonationButtonState> {
  DonationButtonCubit() : super(DonationButtonInitial());

  Future<void> donateToProject({required int projectId, required int amount}) async {
    emit(DonationButtonLoading());

    try {
      final response = await Api().post(
  url: "http://$localhost/api/donor/donateToProject/?id=$projectId&amount=$amount",
  token: "$token",
  body: {}, 
);


      print("Donation response: $response");

      emit(DonationButtonSuccess());
    } catch (e) {
      print("Donation error: $e");
      emit(DonationButtonFailure("فشل التبرع: $e"));
    }
  }
}
