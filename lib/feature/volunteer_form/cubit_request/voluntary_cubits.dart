import 'package:charity_app/feature/volunteer_form/cubit_request/voluntary_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoluntaryCubits extends Cubit<VoluntaryState> {
  VoluntaryCubits() : super(VolunteeringSubmittedInital());

  Future<void> sendVolintaryRequest({
    required phoneController,
    required locationController,
    required String study,
    required birthDateController,
    required String gender,
    required fieldOfStudyController,
    required hoursCountController,
    required volunteerGoalController,
  }) async {
    emit(VolunteeringSubmittedLoading());
    try {
      final token = sharedPreferences.get("token");
      await Api().post(
        url: "http://$localhost/api/donor/volunteerRequest",
        body: {
          "phone_number": phoneController.text,
          "age": birthDateController.text,
          "place_of_residence": locationController.text,
          "your_last_educational_qualification": study,
          "your_studying_domain": fieldOfStudyController.text,
          "gender": gender,
          "volunteering_hours": hoursCountController.text,
          "purpose_of_volunteering": volunteerGoalController.text,
        },
        token: "$token",
      );
      emit(VolunteeringSubmittedSuccess());
    } catch (e) {
      print('ERROR CONTENT: ${e.toString()}');

      final errorString = e.toString();

      final match = RegExp(r'message: (.*?)\}').firstMatch(errorString);
      final message = match?.group(1);

      if (message != null) {
        if (message == "رقم الهاتف مستخدم بالفعل من قبل مستخدم آخر.") {
          emit(PhoneNumberAlredyUsed());
          return;
        }

        if (message ==
            "لقد قمت بالتسجيل على استبيان التطوع مسبقًا ولا يمكنك التسجيل مرة أخرى.") {
          emit(VolunteeringSubmittedAlredySend());
          return;
        }
      }

      // "رقم الهاتف مستخدم بالفعل من قبل مستخدم آخر."
      // "لقد قمت بالتسجيل على استبيان التطوع مسبقًا ولا يمكنك التسجيل مرة أخرى."
      emit(VolunteeringSubmittedFailure());
    }
  }
}
