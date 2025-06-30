// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:charity_app/auth/cubits/auth_cubits/auth_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class AuthCubits extends Cubit<AuthStates> {
  AuthCubits() : super(InitializeState());
//  UserModel? currentUser;

  Future<void> signUpFunction(
      {required fullNameController,
      required emailController,
      required passwordConfirmationController,
      required passwordController,
      required phoneNumberController}) async {
    emit(LoadingStates());
    try {
      final responseData = await Api().post(
        //10.0.2.2:8000
        url: "http://$localhost/api/register",
        body: {
          "full_name": fullNameController.text,
          "email": emailController.text,
          "phone_number": phoneNumberController.text,
          "password": passwordController.text,
          "password_confirmation": passwordConfirmationController.text,
        },
        token: '',
      );
      final email = responseData['user']['email'];
      await sharedPreferences.setString('email', email);

      // final currentUser = UserModel.fromJson(responseData['user']);
      // print(currentUser.fullName);

      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterFailureState(e.toString()));
    }
  }

  Future<void> logInFunction({
    required emailController,
    required passwordController,
  }) async {
    emit(LoadingStates());

    try {
      final response = await Api().post(
        url: "http://$localhost/api/login",
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
        token: '',
      );
      // final user = response['user'];
      final token = response['token'];
      final balance = response['user']['balance'];
      final points = response['user']['points'];
      final unread_count =
          int.tryParse(response['unread_count'].toString()) ?? 0;

      //الرصيد أنا معرفتو مرتين مرة هون ومرا جوا الكيوبت يلي  بالمحفظة
      //في فكرة أنو انا بدي الرصيد فورا يتحدث أنا وعم عبي ف هاد الشي عم يساعدني فيه الرصيد يلي جوا المحفظة
      //أما لما عم اعمل لوغ اوت عم يصفر الرصيد أو يرجعلي بنل  فعرفت كمان الرصيد يلي جوا اللوغ ان
      await sharedPreferences.setString('token', token);
      await sharedPreferences.setString('balance', balance.toString());
      await sharedPreferences.setString('points', points.toString());
      await sharedPreferences.setString(
          'unread_count', unread_count.toString());

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }

  Future<void> logOutFunction() async {
    emit(LoadingStates());
    try {
      final response = await Api().post(
          url: "http://$localhost/api/logout", body: null, token: "$token");
      if (response["message"] == 'Logout successful') {
        emit(LogOutSuccess());
        print(response);
      } else {
        emit(LogOutFailure());
        print(response);
      }
    } catch (ex) {
      emit(LogOutFailure());
    }
  }
}
