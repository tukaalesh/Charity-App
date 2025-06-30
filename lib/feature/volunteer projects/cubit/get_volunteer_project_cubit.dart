import 'package:bloc/bloc.dart';
import 'package:charity_app/feature/volunteer%20projects/model/voluntter_project_model.dart';
import 'package:charity_app/feature/volunteer%20projects/cubit/get_volunteer_project_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class VolunteerProjectsCubit extends Cubit<VolunteerProjectsState> {
  VolunteerProjectsCubit() : super(VolunteerProjectsInitial());

  Future<void> fetchProjectsByType(String type) async {
    emit(VolunteerProjectsLoading());
    try {
      final response = await Api().get(
        token: "",
        url:
            'http://$localhost/api/getVolunteerProjectsByType/${Uri.encodeComponent(type)}',
      );
      print('Requesting projects with URL: $response');

      final List<VoluntterProjectModel> projects = (response as List)
          .map((e) => VoluntterProjectModel.fromJson(e))
          .toList();

      emit(VolunteerProjectsSuccess(projects));
    } catch (e) {
      emit(VolunteerProjectsError(e.toString()));
    }
  }
}
