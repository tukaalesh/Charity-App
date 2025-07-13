import 'package:charity_app/feature/donation_history/model/history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'donation_history_state.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class DonationHistoryCubit extends Cubit<DonationHistoryState> {
  DonationHistoryCubit() : super(DonationHistoryInitial());

  Future<void> loadDonations() async {
    emit(DonationHistoryLoading());

    try {
      final response = await Api().get(
        url: "http://$localhost/api/donations/user",
        token: "$token",
      );

      final List<dynamic> data = response;
      final donations = data.map((e) => HistoryModel.fromJson(e)).toList();

      emit(DonationHistoryLoaded(donations));
    } catch (e) {
      emit(DonationHistoryError('حدث خطأ: $e'));
    }
  }
}
