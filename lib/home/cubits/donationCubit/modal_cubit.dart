import 'package:bloc/bloc.dart';

class ModalCubit extends Cubit<String> {
  ModalCubit() : super('');

  void selectAmount(String amount) => emit(amount);

  void clearAmount() => emit('');
}
