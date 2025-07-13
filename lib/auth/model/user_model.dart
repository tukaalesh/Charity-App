class UserModel {
  final int id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final int points;
  final int unreadNotifications;
  final int balance;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.points,
    required this.unreadNotifications,
    required this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final jsonUserData = json['user'] ?? {};

    return UserModel(
      id: jsonUserData['id'] ?? 0,
      fullName: jsonUserData['full_name'] ?? '',
      email: jsonUserData['email'] ?? '',
      phoneNumber: jsonUserData['phone_number'] ?? '',
    balance: (jsonUserData["balance"] is int)
          ? jsonUserData["balance"]
          : int.tryParse(jsonUserData["balance"]?.toString() ?? '0') ?? 0,

      points: (jsonUserData['points'] is int)
          ? jsonUserData['points']
          : int.tryParse(jsonUserData['points']?.toString() ?? '0') ?? 0,
      unreadNotifications: json['number of unread notifications'] ?? 0,
    );
  }
  //هاد الشي المسؤول عن التعديل
  //تبع عداد الرسائل
  UserModel copyWith({
    int? id,
    int? balance,
    String? fullName,
    String? phoneNumber,
    String? email,
    int? points,
    int? unreadNotifications,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      points: points ?? this.points,
      balance :balance?? this.balance,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
    );
  }
}
