import 'package:charity_app/feature/wallet/cubit/wallet_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCubit extends Cubit<WalletStates> {
  WalletCubit() : super(Walletinitial());
  //تابع مسؤول عن شحن المحفظة
  Future<void> chargeWallet(
      {required bankAccountController, required moneyController}) async {
    emit(WalletLoading());
    try {
      final token = sharedPreferences.getString('token');
      await Api().post(
          url: "$baseUrl/api/donor/addToBalance",
          body: {
            "card_number": bankAccountController.text,
            "amount": moneyController.text,
          },
          token: "$token");

      emit(WalletSuccess());
    } catch (ex) {
      emit(WalletFailure());
    }
  }
}
