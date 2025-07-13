import 'package:charity_app/feature/opportunities/model/project_model.dart';

class DonationModel {
  final int id;
  final String title;
  final String imageUrl;
  final int? totalAmount;
  final int currentAmount;
  final String? description;

  DonationModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.totalAmount,
    required this.currentAmount,
    this.description,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      title: json['name'] ?? '',
      imageUrl: json['photo_url'] ?? '',
      totalAmount: json['total_amount'],
      currentAmount: json['current_amount'] ?? 0,
      description: json['description'],
    );
  }
}

extension DonationToProject on DonationModel {
  ProjectModel toProjectModel() {
    return ProjectModel(
      id: id,
      name: title,
      photoUrl: imageUrl,
      totalAmount: totalAmount ?? 0,
      currentAmount: currentAmount,
      status: 'متاح',
      description: description,
    );
  }
}
// هاد الكود استخدمتو مشان البوتم شيت 
