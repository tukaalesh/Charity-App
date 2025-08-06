import 'package:charity_app/feature/completed_projects/cubit/completed_projects_states.dart';
import 'package:charity_app/feature/completed_projects/model/completed_projects_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedProjectsCubit extends Cubit<CompletedProjectsStates> {
  CompletedProjectsCubit() : super(CompletedProjectsInit());

  List<CompletedProjectsModel> completedProjects = [];

//التباع المسؤول عن إرجاع المشاريع المنجزة

  Future<void> fetchCompletedProject() async {
    if (isClosed) return;
    emit(CompletedProjectsLoading());
    try {
      final token = sharedPreferences.getString('token');

      final response = await Api().get(
        token: "$token",
        url: '$baseUrl/api/projects/completed',
      );

      completedProjects = (response as List)
          .map((e) => CompletedProjectsModel.fromJson(e))
          .toList();

      if (isClosed) return;
      emit(CompletedProjectsSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(CompletedProjectsError(e.toString()));
    }
  }
}
