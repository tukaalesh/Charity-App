// zakah_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:charity_app/feature/zakat/cubit/zakah_state.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class ZakahCubit extends Cubit<ZakahState> {
  ZakahCubit() : super(ZakahInitial());

  String? selectedCategory;

  void selectCategory(String category) {
    selectedCategory = category;
    emit(ZakahCategorySelected(category));
  }

  Future<void> donateZakah(double amount, String type) async {
    emit(ZakahLoading());

    try {
      final balanceString = sharedPreferences.getString('balance') ?? '0';
      final balance = double.tryParse(balanceString) ?? 0.0;

      if (amount > balance) {
        emit(ZakahFailure("الرصيد غير كافٍ"));
        return;
      }

      final response = await Api().post(
        url: "http://$localhost/api/donor/giveZakat",
        body: {
          'amount': amount.toString(),
          'type': type,
        },
        token: "$token",
      );
      if (response is Map && response.containsKey('message')) {
        final message = response['message'];

        if (message.contains('نجاح') || message.contains('تمت')) {
          final newBalance = balance - amount;
          await sharedPreferences.setString('balance', newBalance.toString());
          emit(ZakahSuccess(newBalance));
        } else {
          emit(ZakahFailure(message));
        }
      }
    } catch (ex) {
      emit(ZakahFailure("حدث خطأ أثناء التبرع بالزكاة"));
    }
  }
}
