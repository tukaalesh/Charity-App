// splash_cubit.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:charity_app/auth/cubits/splash_cubits/splash_states.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 5), () {
      emit(SplashCompleted());
    });
  }
}
