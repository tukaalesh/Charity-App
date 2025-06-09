import 'package:charity_app/feature/wallet/cubit/wallet_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WalletCubit extends Cubit<WalletStates> {
  WalletCubit() : super(initialState());
  // ignore: non_constant_identifier_names
  Future<void> chargeWallet(
      {required bankAccountController, required moneyController}) async {
    emit(LoadingState());
    final token = sharedPreferences.get('token');
    try {
      await Api().post(
          url: "",
          body: {
            "": bankAccountController.text,
            // ignore: equal_keys_in_map
            "": moneyController.text,
          },
          token: "$token");
    } catch (ex) {
      emit(FailureState());
    }
  }
}
