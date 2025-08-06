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
      final token = sharedPreferences.get("token");

      final response = await Api().post(
        url: "$baseUrl/api/donor/giveZakat",
        body: {
          'amount': amount.toString(),
          'type': type,
        },
        token: "$token",
      );

      if (response is Map && response.containsKey('message')) {
        final msg = response['message'].toString();

        if (msg.contains('تم استلام الزكاة') ||
            msg.contains('تم التبرع بنجاح')) {
          emit(ZakahSuccess());
        } else {
          emit(ZakahFailure(msg));
        }
      }
    } catch (e) {
      emit(ZakahFailure("حدث خطأ أثناء إرسال الزكاة"));
    }
  }
}
