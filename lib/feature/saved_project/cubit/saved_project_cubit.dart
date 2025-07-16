import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/feature/saved_project/cubit/saved_project_state.dart';
import 'package:charity_app/feature/opportunities/model/project_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class SavedProjectsCubit extends Cubit<SavedProjectsState> {
  SavedProjectsCubit() : super(SavedProjectsInitial());

  Future<void> fetchSavedProjects({String? query}) async {
    emit(SavedProjectsLoading());
    try {
      final token = sharedPreferences.get("token");

      final url = (query != null && query.trim().isNotEmpty)
          ? "http://$localhost/api/favourite/search?query=${Uri.encodeComponent(query.trim())}"
          : "http://$localhost/api/favourite";

      final response = await Api().get(
        url: url,
        token: "$token",
      );

      final projects = (response as List)
          .map((item) => ProjectModel.fromJson(item))
          .toList();

      emit(SavedProjectsLoaded(projects));
    } catch (e) {
      emit(SavedProjectsError(e.toString()));
    }
  }

  Future<void> removeSavedProject(int projectId) async {
    try {
      final token = sharedPreferences.get("token");

      final url = "http://$localhost/api/favourite/?project_id=$projectId";
      await Api().delete(
        url: url,
        token: "$token",
      );
      fetchSavedProjects();
    } catch (e) {
      emit(SavedProjectsError(e.toString()));
    }
  }
  void updateProjectAmount(int projectId, int currentAmount) {
    final currentState = state;
    if (currentState is SavedProjectsLoaded) {
      final updatedProjects = currentState.projects.map((project) {
        if (project.id == projectId) {
          return project.copyWith(
            currentAmount: project.currentAmount + currentAmount,
          );
        }
        return project;
      }).toList();

      emit(SavedProjectsLoaded(updatedProjects));
    }
  }
}
