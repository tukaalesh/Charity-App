// user_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:charity_app/auth/model/user_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/home/cubits/user_drawer/user_state.dart';
import 'package:charity_app/main.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  Future<void> getUserData(String token) async {
    try {
      emit(UserLoadingState());
      final response =
          await Api().get(url: "$baseUrl/api/getUser", token: token);
      final data = Map<String, dynamic>.from(response);
      final user = UserModel.fromJson(data['user']);
      emit(UserSuccessState(user));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
