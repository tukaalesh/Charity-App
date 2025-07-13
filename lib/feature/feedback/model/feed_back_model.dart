class FeedbackModel {
  final String userName;
  final String message;
  final String date;

  FeedbackModel({
    required this.userName,
    required this.message,
    required this.date,
  });

factory FeedbackModel.fromJson(Map<String, dynamic> json) {
  return FeedbackModel(
    userName: json['user_name'] ?? 'مجهول',
    message: json['message'] ?? '',
    date: json['date'] ?? '',
  );
}

}
