import 'package:flutter_bloc/flutter_bloc.dart';

class ModalCubit extends Cubit<String> {
  ModalCubit() : super('');

  void selectAmount(String amount) {
    emit(amount);
  }
}
