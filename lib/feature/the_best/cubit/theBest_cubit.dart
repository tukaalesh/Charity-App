import 'package:charity_app/feature/the_best/cubit/theBest_state.dart';
import 'package:charity_app/feature/the_best/model/theBest_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TheBestCubit extends Cubit<TheBestState> {
  TheBestCubit() : super(TheBestInitial());

  Future<void> fetchTheBest() async {
    emit(TheBestLoading());

    try {
      final token = sharedPreferences.get("token");

      final response = await Api().get(
        url: "$baseUrl/api/getTopDonors",
        token: "$token",
      );

      final List<dynamic> data = response['top_donors'];
      final List<TheBestModel> theBestList =
          data.map((e) => TheBestModel.fromJson(e)).toList();

      emit(TheBestLoaded(theBestList));
    } catch (e) {
      emit(TheBestError("حدث خطأ: $e"));
    }
  }
}
