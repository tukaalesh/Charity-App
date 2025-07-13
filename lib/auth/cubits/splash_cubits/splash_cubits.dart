import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:charity_app/auth/cubits/splash_cubits/splash_states.dart';
import 'package:charity_app/main.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _startTimer();
  }
// التابع المسؤول عن التنقل من السبلاش 
  void _startTimer() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = sharedPreferences.getString('token');
    if (token != null && token.isNotEmpty) {
      
      //في توكن وعامل تسجيل دخول روح على الهوم فوراً من بعد السبلاش 
      //سبلاش هوم 
      emit(SplashCompleted(isLoggedIn: true));

    } else {
      //مافي توكن روح ويلكم  امشي سبلاس ويلكم 
      emit(SplashCompleted(isLoggedIn: false));
    }
  }
}
