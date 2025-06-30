import 'package:charity_app/feature/wallet/cubit/wallet_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCubit extends Cubit<WalletStates> {
  WalletCubit() : super(Walletinitial());
  // ignore: non_constant_identifier_names
  Future<void> chargeWallet(
      {required bankAccountController, required moneyController}) async {
    emit(WalletLoading());
    try {
      final response = await Api().post(
          url: "http://$localhost/api/donor/addToBalance",
          body: {
            "card_number": bankAccountController.text,
            // ignore: equal_keys_in_map
            "amount": moneyController.text,
          },
          token: "$token");

      // print(response);
      final newBalance = response['balance'];
      await sharedPreferences.setString('balance', newBalance.toString());
      emit(WalletSuccess(double.tryParse(newBalance.toString()) ?? 0.0));
    } catch (ex) {
      emit(WalletFailure("حدث خطأ ما ! يُرجى إاعادة المحاولة"));
    }
  }
}
