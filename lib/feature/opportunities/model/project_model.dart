class ProjectModel {
  final int id;
  final String name;
  final String photoUrl;
  final int? totalAmount;
  final int currentAmount;
  final String status;
  final String? description;

  ProjectModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    this.totalAmount,
    required this.currentAmount,
    required this.status,
    this.description,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photo_url'] ?? '',
      totalAmount: json['total_amount'],
      currentAmount: json['current_amount'] ?? 0,
      status: json['status'] ?? '',
      description: json['description'],
    );
  }

  ProjectModel copyWith({
    int? id,
    String? name,
    String? photoUrl,
    int? totalAmount,
    int? currentAmount,
    String? status,
    String? description,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      totalAmount: totalAmount ?? this.totalAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }
}
