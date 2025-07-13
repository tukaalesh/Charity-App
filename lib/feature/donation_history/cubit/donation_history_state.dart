import 'package:charity_app/feature/donation_history/model/history_model.dart';

abstract class DonationHistoryState {}

class DonationHistoryInitial extends DonationHistoryState {}

class DonationHistoryLoading extends DonationHistoryState {}

class DonationHistoryLoaded extends DonationHistoryState {
  final List<HistoryModel> donations;

  DonationHistoryLoaded(this.donations);
}

class DonationHistoryError extends DonationHistoryState {
  final String message;

  DonationHistoryError(this.message);
}
