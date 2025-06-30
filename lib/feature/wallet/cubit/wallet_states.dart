abstract class WalletStates {}

// ignore: camel_case_types
class Walletinitial extends WalletStates {}

class WalletLoading extends WalletStates {}

class WalletSuccess extends WalletStates {
  //مشان ضغري يطلع الرصيد الجديد ضمن ui
  final double newBalance;
  WalletSuccess(this.newBalance);
}

class WalletFailure extends WalletStates {
  final String errorMessage;
  WalletFailure(this.errorMessage);
}
