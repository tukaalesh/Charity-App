import 'package:charity_app/feature/feedback/cubit/feedback_state.dart';
import 'package:charity_app/feature/feedback/model/feed_back_model.dart';
import 'package:charity_app/helper/api.dart';
import 'package:charity_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());

  Future<void> fetchFeedbacks() async {
    emit(FeedbackLoading());

    try {
      final response = await Api().get(
        url: "http://$localhost/api/getAcceptedFeedbacks",
        token: "$token",
      );

      final List<dynamic> feedbackList = response['Feedbacks'];
      final List<FeedbackModel> feedbacks = 
          feedbackList.map((item) => FeedbackModel.fromJson(item)).toList();

      emit(FeedbackLoaded(feedbacks));
    } catch (e) {
      emit(FeedbackError("حدث خطأ: $e"));
    }
  }
}
