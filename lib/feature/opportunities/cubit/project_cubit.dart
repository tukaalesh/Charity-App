import 'package:charity_app/feature/opportunities/cubit/project_state.dart';
import 'package:charity_app/feature/opportunities/model/project_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit() : super(ProjectsInitial());

  Future<void> loadProjectsByType(String type) async {
    emit(ProjectsLoading());

    try {
      final response = await Api().get(
        url: "http://$localhost/api/donor/projects/$type",
        token: "$token",
      );

      final List<dynamic> data = response;
      final projects = data.map((e) => ProjectModel.fromJson(e)).toList();

      emit(ProjectsLoaded(projects));
    } catch (e) {
      emit(ProjectsError('حدث خطأ: $e'));
    }
  }
  void updateProject(ProjectModel updatedProject) {
  if (state is ProjectsLoaded) {
    final currentProjects = (state as ProjectsLoaded).projects;
    final index = currentProjects.indexWhere((p) => p.id == updatedProject.id);

    if (index != -1) {
      final updatedList = List<ProjectModel>.from(currentProjects);
      updatedList[index] = updatedProject;
      emit(ProjectsLoaded(updatedList));
    }
  }
}

}
