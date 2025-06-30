import 'package:charity_app/feature/volunteer%20request/cubit/cubit_request/voluntary_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoluntaryCubits extends Cubit<VoluntaryState> {
  VoluntaryCubits() : super(VoluntaryInital());

  Future<void> sendVolintaryRequest(
      {required phoneController,
      required goalController,
      required locationController,
      required hourController,
      required birthDateController,
      required selectedGender,
      required selectedLevel,
      required selectedDomain}) async {
    emit(VoluntaryLoading());
    try {
      //  final token = sharedPreferences.get("token");
      await Api().post(
          //ح عدلو بس ترد تبعتلي ياه حلا
          //حاسة فيه شي نت اوك
          url: "http://$localhost/api/donor/volunteerRequest",
          body: {
            "phone_number": phoneController.text,
            "age": birthDateController.text,
            "purpose_of_volunteering": goalController.text,
            "current_location": locationController.text,
            "volunteering_hours": hourController.text,
            //هون مافي .text
            // بينما selectedGender أصلاً عبارة عن String مو TextEditingController.
            "gender": selectedGender,
            "volunteering_domain": selectedDomain,
            "education": selectedLevel,
          },
          token: "$token");
      emit(VoluntarySuccess());
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
      emit(VoluntaryFailure());
    }
  }
}
          // url: "http://127.0.0.1:8000/api/donor/volunteerRequest",
