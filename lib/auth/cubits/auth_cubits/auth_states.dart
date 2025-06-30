//Auth : for log in screen aand sign up screen >>..<<
//تحديد الستيتس يلي رح تاخدهم لسكرين اثناء لوغ ان او الساين اب

abstract class AuthStates {}

class InitializeState extends AuthStates {}

class LoadingStates extends AuthStates {}

//عرفت لويدنغ مره وحدة لانو مابيفرق اما حالة النجاح والفشل لازم يتعرفو مرتين مشان مايصير في خربطة

class RegisterSuccessState extends AuthStates {}

class RegisterFailureState extends AuthStates {
  final String error;
  RegisterFailureState(this.error);
}

class LoginSuccessState extends AuthStates {}

class LoginFailureState extends AuthStates {
  final String error;
  LoginFailureState(this.error);
}

class LogOutSuccess extends AuthStates {}

class LogOutFailure extends AuthStates {}
