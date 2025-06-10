import 'package:charity_app/feature/gift/cubit/send_gift_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendGiftCubit extends Cubit<SendGiftStates> {
  SendGiftCubit() : super(initialState());
  // ignore: non_constant_identifier_names
  Future<void> sendGift(
      {required nameController,
      required phoneController,
      required moneyController}) async {
    emit(LoadingState());
   // final token = sharedPreferences.get('token');
    try {
      await Api().post(
          url: "",
          body: {
            "": nameController.text,
            // ignore: equal_keys_in_map
            "": phoneController.text,
            // ignore: equal_keys_in_map
            "": moneyController.text,
          },
          token: "$token");
    } catch (ex) {
      emit(FailureState());
    }
  }
}
