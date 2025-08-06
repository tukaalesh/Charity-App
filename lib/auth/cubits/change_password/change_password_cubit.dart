// ignore_for_file: avoid_print

import 'package:charity_app/auth/cubits/change_password/change_password_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordinilation());
//التابع المسؤول عن تغيير كلمة السر
  Future<void> changePasswordFunction({
    required newPasswordController,
    required confirmationNewPasswordController,
  }) async {
    emit(ChangePasswordLoading());

    try {
      final token = sharedPreferences.getString('token');
      final response = await Api().put(
        url: "$baseUrl/api/editpassword",
        body: {
          "new_password": newPasswordController.text,
          "new_password_confirmation": confirmationNewPasswordController.text
        },
        token: "$token",
      );

      print(response);

      if (response['message'] == "password has been changed successfully") {
        emit(ChangePasswordSuccess());
      } else {
        emit(ChangePasswordFailure());
      }
    } catch (ex) {
      emit(ChangePasswordFailure());
    }
  }
}
