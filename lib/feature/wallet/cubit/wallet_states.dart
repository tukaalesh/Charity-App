abstract class WalletStates {}

// ignore: camel_case_types
class initialState extends WalletStates {}

class LoadingState extends WalletStates {}

class SuccessState extends WalletStates {
  //مشان ضغري يطلع الرصيد الجديد ضمن ui
  final double newBalance;
  SuccessState(this.newBalance);
}

class FailureState extends WalletStates {}
