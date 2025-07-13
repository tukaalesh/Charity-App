// zakah_state.dart
abstract class ZakahState {}

class ZakahInitial extends ZakahState {}

class ZakahLoading extends ZakahState {}

class ZakahSuccess extends ZakahState {
  final double newBalance;
  ZakahSuccess(this.newBalance);
}

class ZakahFailure extends ZakahState {
  final String message;
  ZakahFailure(this.message);
}

class ZakahCategorySelected extends ZakahState {
  final String category;
  ZakahCategorySelected(this.category);
}
