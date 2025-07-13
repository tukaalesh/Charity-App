class TheBestModel {
  final String name;
  final int points;

  TheBestModel({
    required this.name,
    required this.points,
  });

  factory TheBestModel.fromJson(Map<String, dynamic> json) {
    ///print(json); 

    return TheBestModel(
      
      name: json['full_name'],
       points: (json['points'] is int)
          ? json['points']
          : int.tryParse(json['points']?.toString() ?? '0') ?? 0,
    );
  }
}
