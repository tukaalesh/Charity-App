// ignore_for_file: avoid_print

import 'package:charity_app/auth/cubits/change_password/change_password_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(inilationStates());

  Future<void> changePasswordFunction({
    required newPasswordController,
    required confirmationNewPasswordController,
  }) async {
    emit(LoadingStates());

    try {
      final token = sharedPreferences.getString('token');

      final response = await Api().put(
        url: "http://127.0.0.1:8000/api/editpassword",
        body: {
          "new_password": newPasswordController.text,
          "new_password_confirmation": confirmationNewPasswordController.text
        },
        token: token,
      );

      //print('Response: $response');

      if (response['message'] == 'password has been changed successfully') {
        emit(SuccessStates());
      } else {
        emit(FailureStates());
      }
    } catch (ex) {
      print('Exception: $ex');
      emit(FailureStates());
    }
  }
}
