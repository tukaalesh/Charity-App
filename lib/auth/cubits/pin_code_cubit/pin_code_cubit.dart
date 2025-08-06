// ignore_for_file: avoid_print

import 'package:charity_app/auth/cubits/pin_code_cubit/pin_code_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeCubit extends Cubit<PinCodeStates> {
  PinCodeCubit() : super(PinCodeinilation());

  //التابع المسؤول عن التحقق تبع pin code
  Future<void> checkCode({
    required String email,
    required String code,
  }) async {
    emit(PinCodeLoading());

    try {
      final token = sharedPreferences.getString('token');
      final response = await Api().post(
        url: "$baseUrl/api/verifyEmail",
        body: {
          "email": email,
          "verification_code": code,
        },
        token: "$token",
      );

      print('Response: $response');
      emit(PinCodeSuccess());
    } catch (ex) {
      print('Exception: $ex');
      emit(PinCodeFailure());
    }
  }
}
