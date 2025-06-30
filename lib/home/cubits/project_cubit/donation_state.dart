
import 'package:charity_app/home/model/donation_model.dart';

abstract class DonationState {}

class DonationInitial extends DonationState {}

class DonationLoading extends DonationState {}

class DonationLoaded extends DonationState {
  final List<projectModel> projects;

  DonationLoaded(this.projects);
}

class DonationError extends DonationState {
  final String message;

  DonationError(this.message);
}
