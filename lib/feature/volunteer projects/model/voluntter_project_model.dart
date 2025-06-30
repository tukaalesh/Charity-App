// ignore_for_file: non_constant_identifier_names

class VoluntterProjectModel {
  final int id;
  final String name;
  final String location;
  final String volunteer_hours;
  final String required_tasks;
  final String status;
  final String? description;
  final int? total_amount;
  final int? current_amount;

  VoluntterProjectModel({
    required this.id,
    required this.name,
    required this.location,
    required this.volunteer_hours,
    required this.required_tasks,
    required this.status,
    this.description,
    this.total_amount,
    this.current_amount,
  });

  factory VoluntterProjectModel.fromJson(Map<String, dynamic> json) {
    return VoluntterProjectModel(
      id: json["id"],
      name: json["name"],
      location: json["location"],
      volunteer_hours: json["volunteer_hours"],
      required_tasks: json["required_tasks"],
      status: json["status"],
      description: json["description"],
      total_amount: json["total_amount"],
      current_amount: json["current_amount"],
    );
  }
}
// {
//         "id": 1,
//         "name": "دعم تعليم الأطفال في المناطق الفقيرة",
//         "description": "تعليم مهارات القراءة والكتابة للأطفال الذين ليس لهم فرص تعليم كافية",
//         "total_amount": 10,
//         "current_amount": 0,
//         "status": "جاري",
//         "location": "عين ترما",
//         "volunteer_hours": " 3 ساعات أسبوعياً ",
//         "required_tasks": "شرح المفاهيم الصعبة، تحضير ملخصات، تقديم اختبارات تجريبية ",

//     },
    