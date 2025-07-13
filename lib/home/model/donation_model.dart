// ignore_for_file: camel_case_types

class projectModel {
  final String title;
  final String imageUrl;
  final int targetAmount;
  final int donatedAmount;

  projectModel({
    required this.title,
    required this.imageUrl,
    required this.targetAmount,
    required this.donatedAmount,
  });

  factory projectModel.fromJson(Map<String, dynamic> json) {
    return projectModel(
      title: json['title'],
      imageUrl: json['image_url'],
      targetAmount: json['target_amount'],
      donatedAmount: json['donated_amount'],
    );
  }
}
