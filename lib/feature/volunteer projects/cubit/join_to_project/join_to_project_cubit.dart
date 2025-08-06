// ignore_for_file: unused_local_variable, avoid_print

import 'package:charity_app/feature/volunteer%20projects/cubit/join_to_project/join_to_project_states.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinToProjectCubit extends Cubit<JoinToProjectStates> {
  JoinToProjectCubit() : super(JoinToProjectInit());

  Future<void> joinToProject({required id}) async {
    final token = sharedPreferences.get("token");
    emit(JoinToProjectLoding());
    try {
      final response = await Api().post(
        url: "$baseUrl/api/volunteer/volunteerInProject/",
        body: {
          "id": id.toString(),
        },
        token: "$token",
      );
      print('object1');
      emit(JoinToProjectSuccess());
    } catch (e) {
      //حالات التطوع كلها معالجة بأذن الله

      print('ERROR CONTENT: ${e.toString()}');

      final errorString = e.toString();

      final match = RegExp(r'message: (.*?)\}').firstMatch(errorString);
      final message = match?.group(1);

      if (message != null) {
        if (message == "لا يمكنك التطوع في مشروعين بنفس الوقت") {
          emit(JoinToProjectAlreadyApplied());
          return;
        }

        if (message ==
            "لا يمكنك التطوع في هذا المشروع، للمساهمة في نشر الخير يمكنك التسجيل كمتطوع في جمعيتنا عن طريق تعبئة استبيان التطوع الخاص بنا") {
          emit(JoinToProjectNoSurvey());
          return;
        }
        if (message ==
            "لا يزال طلب التطوع خاصتك قيد الدراسة، يمكنك البدء بالتطوع عندما يتم قبول طلبك") {
          emit(JoinToProjectPendingApproval());
          return;
        }
        if (message ==
            "تم رفض طلب تطوعك في الجمعية لأسباب متعلقة بسياسة الجمعية، لمتابعة التفاصيل أو الاعتراض، يُرجى التواصل مع إدارة التطبيق على صفحة الفيسبوك الخاصة بالجمعية") {
          emit(JoinToProjectRejected());
          return;
        }
        if (message ==
            "تم إيقاف تطوعك في الجمعية بسبب مخالفات في تنفيذ المهام التطوعية، لمتابعة التفاصيل أو الاعتراض، يُرجى التواصل مع إدارة التطبيق على صفحة الفيسبوك الخاصة بالجمعية") {
          emit(JoinToProjectBlocked());
          return;
        }
      }

      emit(JoinToProjectFailure());
    }
  }
}
