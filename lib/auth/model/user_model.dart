
class UserModel {
  String email;
  String phoneNumber;
  String fullName;
  UserModel({
    required this.email,
    required this.phoneNumber,
   required this.fullName
  });
  factory UserModel.fromJson(Map<String, dynamic> jsonUserData) {
    
    return UserModel(
      fullName: jsonUserData[ "full_name"],
      email: jsonUserData['email'],
      phoneNumber: jsonUserData['phone_number'],
    );
    
  }
  
  
}
// {
//     "data": {
//         "id": 13,
//         "full_name": "hala soliman",
//         "email": "hala2@gmail.com",
//         "phone_number": "0993748511"
//     }
// }
// {
//     "message": "User Registered Successfully",
//     "user": {
//         "full_name": "hala soliman",
//         "phone_number": "0993748511",
//         "email": "hala2@gmail.com",
//         "updated_at": "2025-05-28T18:26:20.000000Z",
//         "created_at": "2025-05-28T18:26:20.000000Z",
//         "id": 13
//     }
// }