import 'package:bloc/bloc.dart';

class SliderCubit extends Cubit<int> {
  SliderCubit() : super(0);//الحالة الابتدائية

  void changeIndex(int index) => emit(index);
}

