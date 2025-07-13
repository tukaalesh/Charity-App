import 'package:charity_app/feature/the_best/model/theBest_model.dart';

abstract class TheBestState {}

class TheBestInitial extends TheBestState {}

class TheBestLoading extends TheBestState {}

class TheBestLoaded extends TheBestState {
  final List<TheBestModel> bestList;

  TheBestLoaded(this.bestList);
}

class TheBestError extends TheBestState {
  final String message;

  TheBestError(this.message);
}
