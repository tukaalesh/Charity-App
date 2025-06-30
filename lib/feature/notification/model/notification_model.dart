class NotificationModel {
  final String title;
  final String message;
  final String time;

  NotificationModel(
      {required this.message, required this.title, required this.time});
  factory NotificationModel.fromJson(Map<String, dynamic> jsonUserData) {
    return NotificationModel(
      message: jsonUserData['message'],
      title: jsonUserData["title"],
      time: jsonUserData['sent_at'],
    );
  }
}
