import 'package:bloc/bloc.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/get_volunteer/get_volunteer_project_states.dart';
import 'package:charity_app/feature/volunteer%20projects/model/voluntter_project_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class VolunteerProjectsCubit extends Cubit<VolunteerProjectsState> {
  VolunteerProjectsCubit() : super(VolunteerProjectsInitial());
  Future<void> fetchProjectsByType(String type) async {
    if (isClosed) return;
    emit(VolunteerProjectsLoading());
    try {
      final token = sharedPreferences.getString('token');

      final response = await Api().get(
        token: "$token",
        url:
            '$baseUrl/api/getVolunteerProjectsByType/${Uri.encodeComponent(type)}',
      );

      final List<VoluntterProjectModel> projects = (response as List)
          .map((e) => VoluntterProjectModel.fromJson(e))
          .toList();

      if (isClosed) return;
      emit(VolunteerProjectsSuccess(projects));
    } catch (e) {
      if (isClosed) return;
      emit(VolunteerProjectsError(e.toString()));
    }
  }
}
