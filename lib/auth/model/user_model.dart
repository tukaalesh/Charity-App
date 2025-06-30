class UserModel {
  final int id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final int points;
  final int unreadNotifications;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.points,
    required this.unreadNotifications,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final jsonUserData = json['user'] ?? {};

    return UserModel(
      id: jsonUserData['id'] ?? 0,
      fullName: jsonUserData['full_name'] ?? '',
      email: jsonUserData['email'] ?? '',
      phoneNumber: jsonUserData['phone_number'] ?? '',
      points: (jsonUserData['points'] is int)
          ? jsonUserData['points']
          : int.tryParse(jsonUserData['points']?.toString() ?? '0') ?? 0,
      unreadNotifications: json['number of unread notifications'] ?? 0,
    );
  }
}
// بالموديل في ششي لليوزر وفي شي للرسائل الغير مقروءة
// {
//     "user": {
//         "id": 1,
//         "full_name": "tuka",
//         "phone_number": "0999999999",
//         "email": "tukaaalesh8@gmail.com",
//         "verification_code": "1111",
//         "verified": 1,
//         "date_of_birth": null,
//         "gender": null,
//         "role": "متبرع",
//         "balance": 299.5,
//         "points": 51,
//         "beneficiary_last_order": null,
//         "beneficiary_status": null,
//         "monthly_donation": 100.5,
//         "last_monthly_donation": "2025-06-25",
//         "ban": 0,
//         "volunteer_status": null,
//         "is_working": 0,
//         "purpose_of_volunteering": null,
//         "current_location": null,
//         "volunteering_hours": null,
//         "education": null,
//         "email_verified_at": null,
//         "created_at": "2025-06-24T20:01:59.000000Z",
//         "updated_at": "2025-06-29T18:02:07.000000Z"
//     },
//     "number of unread notifications": 0
// }
