// lib/feature/notification/cubit/notification_cubit.dart
import 'package:charity_app/feature/notification/cubit/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity_app/feature/notification/model/notification_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void fetchNotifications() async {
    emit(NotificationLoading());
    try {
      final res = await Api().post(
        url: "http://$localhost/api/notifications",
        token: "$token",
        body: null,
      );

      final List list = res['notifications'];
      final notifications =
          list.map((e) => NotificationModel.fromJson(e)).toList();

      emit(NotificationSuccess(notifications));
    } catch (e) {
      emit(NotificationError("حدث خطأ أثناء جلب البيانات"));
    }
  }
}
