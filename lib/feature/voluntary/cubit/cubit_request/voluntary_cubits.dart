import 'package:charity_app/feature/voluntary/cubit/cubit_request/voluntary_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoluntaryCubits extends Cubit<VoluntaryState> {
  VoluntaryCubits() : super(InitalState());

  Future<void> sendVolintaryRequest(
      {required phoneController,
      required goalController,
      required locationController,
      required hourController,
      required birthDateController,
      required selectedGender,
      required selectedLevel,
      required selectedDomain}) async {
    emit(LoadingState());
    try {
      await Api().post(
        //ح عدلو بس ترد تبعتلي ياه حلا
          url: "http://127.0.0.1:8000/api/",
          body: {
            "phone_number": phoneController.text,
            "age": birthDateController.text,
            "purpose_of_volunteering": goalController.text,
            "current_location": locationController.text,
            "volunteering_hours": hourController.text,
            "gender": selectedGender.text,
            "volunteering_domain": selectedDomain.text,
            "education": selectedLevel.text,
          },
          token: 'token');
      emit(SuccessState());
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      emit(FailureState());
    }
  }
}
