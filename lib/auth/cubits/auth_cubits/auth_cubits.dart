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
      // final responseData =
      await Api().post(
        //10.0.2.2:8000
        url: "http://10.0.2.2:8000/api/register",
        body: {
          "full_name": fullNameController.text,
          "email": emailController.text,
          "phone_number": phoneNumberController.text,
          "password": passwordController.text,
          "password_confirmation": passwordConfirmationController.text,
        },
        token: '',
      );

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
        url: "http://10.0.2.2:8000/api/login",
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
        token: '',
      );
      final token = response['token'];
      final userName = response['user']['full_name'];
      // print(userName);

      await sharedPreferences.setString('token', token);
      await sharedPreferences.setString('userName', userName);

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }
}
