import 'package:bloc/bloc.dart';
import 'package:charity_app/home/cubits/project_cubit/donation_state.dart';
import 'package:charity_app/home/cubits/donation_repositry.dart';

class DonationCubit extends Cubit<DonationState> {
  final DonationRepositry repository;

  DonationCubit(this.repository) : super(DonationInitial());

  Future<void> loadProjects() async {
    emit(DonationLoading());
    // ignore: avoid_print
    print("تحميل المشاريع بدأ "); 
    try {
      final projects = await repository.fetchProjects();
      emit(DonationLoaded(projects));
      // ignore: avoid_print
      print("تم تحميل المشاريع بنجاح: ${projects.length} ");
    } catch (e) {
      emit(DonationError(e.toString()));
      // ignore: avoid_print
      print("فشل في تحميل المشاريع : $e");
    }
  }
}
