// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:charity_app/zakat/cubit/zakah_state.dart';

class ZakahCubit extends Cubit<ZakahState> {
  ZakahCubit() : super(ZakahInitial());

  Future<void> donateZakah(double amount) async {
    emit(ZakahLoading());

    try {
      //للتحقق اذا كان الرصيد بكفي
      final balanceString = sharedPreferences.getString('balance') ?? '0';
      final balance = double.tryParse(balanceString) ?? 0.0;

      if (amount > balance) {
        emit(ZakahFailure(" الرصيد غير كافٍ"));
        return;
      }

      final response = await Api().post(
          url: "http://$localhost/api/donor/giveZakat",
          body: {'amount': amount.toString()},
          token: "$token");
      print('balance: $balance');

      print('amount: $amount');

      if (response is Map && response.containsKey('message')) {
        final message = response['message'];

        if (message.contains('نجاح') || message.contains('تمت')) {
          final newBalance = balance - amount;
          await sharedPreferences.setString('balance', newBalance.toString());
          print('balance: $newBalance');
          emit(ZakahSuccess(newBalance));
        } else {
          emit(ZakahFailure(message));
        }
      }
    } catch (ex) {
      print("Error donating zakah: $ex");
      emit(ZakahFailure("حدث خطأ أثناء التبرع بالزكاة"));
    }
  }
}
