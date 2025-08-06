import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:charity_app/feature/opportunities/model/project_model.dart';

abstract class SavedState {}

class FavoriteInitial extends SavedState {}

class FavoriteLoading extends SavedState {}

class FavoriteSuccess extends SavedState {}

class FavoriteFailure extends SavedState {
  final String message;
  FavoriteFailure(this.message);
}

class SavedButtonCubit extends Cubit<SavedState> {
  SavedButtonCubit() : super(FavoriteInitial());

  Future<void> addProjectToFavorites(ProjectModel project) async {
    emit(FavoriteLoading());
    try {
      final token = sharedPreferences.get("token");

      final url = "$baseUrl/api/favourite?project_id=${project.id}";

      final response = await Api().post(
        url: url,
        token: "$token",
        body: {
          "project_id": project.id.toString(),
        },
      );

      print("Add to favorites response: $response");

      emit(FavoriteSuccess());
    } catch (e) {
      print("Add to favorites error: $e");
      emit(FavoriteFailure(e.toString()));
    }
  }
}
