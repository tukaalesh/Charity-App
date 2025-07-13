import 'package:charity_app/feature/opportunities/model/project_model.dart';

abstract class SavedProjectsState {}

class SavedProjectsInitial extends SavedProjectsState {}

class SavedProjectsLoading extends SavedProjectsState {}

class SavedProjectsLoaded extends SavedProjectsState {
  final List<ProjectModel> projects;
  SavedProjectsLoaded(this.projects);
}

class SavedProjectsError extends SavedProjectsState {
  final String message;
  SavedProjectsError(this.message);
}
