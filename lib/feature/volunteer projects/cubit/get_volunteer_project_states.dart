// get_volunteer_project_states.dart
import 'package:charity_app/feature/volunteer%20projects/model/voluntter_project_model.dart';

abstract class VolunteerProjectsState {}

class VolunteerProjectsInitial extends VolunteerProjectsState {}

class VolunteerProjectsLoading extends VolunteerProjectsState {}

class VolunteerProjectsSuccess extends VolunteerProjectsState {
  final List<VoluntterProjectModel> projects;

  VolunteerProjectsSuccess(this.projects);
}

class VolunteerProjectsError extends VolunteerProjectsState {
  final String message;

  VolunteerProjectsError(this.message);
}
