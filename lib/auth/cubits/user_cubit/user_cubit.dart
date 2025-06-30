// user_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:charity_app/auth/cubits/user_cubit/user_states.dart';
import 'package:charity_app/auth/model/user_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  Future<void> getUserData(String token) async {
    try {
      emit(UserLoadingState());
      final response = await Api()
          .get(url: "http://$localhost/api/getUser", token: token);
      final data = Map<String, dynamic>.from(response);
      final user = UserModel.fromJson(data);
      emit(UserSuccessState(user));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
