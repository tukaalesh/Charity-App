
// ignore_for_file: non_constant_identifier_names

class CompletedProjectsModel {
  final String name;
  final String description;
  final String photo_url;

  CompletedProjectsModel({
    required this.name,
    required this.description,
    required this.photo_url,
  });

  factory CompletedProjectsModel.fromJson(Map<String, dynamic> json) {
    return CompletedProjectsModel(
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        photo_url: json['photo_url'] ?? '');
  }
}
 // "name": "تأمين المصاحف والكتب الشرعية",
  //       "description": "يهدف هذا المشروع إلى توفير المصاحف والكتب الإسلامية المعتمدة وتوزيعها على المساجد، المراكز التعليمية، حلقات التحفيظ، والمدارس الشرعية في المناطق المحتاجة. يشمل المشروع طباعة وتوزيع نسخ من القرآن الكريم بأحجام مختلفة، تأمين كتب التفسير، الحديث، الفقه، والسيرة النبوية.",
  //       "type": "ديني",
  //       "photo_url": "http://127.0.0.1:8000/storage/temporary_projects_images/religion_project_002.png",