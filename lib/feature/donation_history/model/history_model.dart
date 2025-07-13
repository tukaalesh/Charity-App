import 'package:intl/intl.dart';

class HistoryModel {
  final String? projectName;
  final String type;
  final int amount;
  final DateTime date;

  HistoryModel( {
    required this.type,
    this.projectName,
    required this.amount,
    required this.date,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('yyyy/MM/dd');

    return HistoryModel(
      projectName: json['project_name'],
      amount: (json['amount'] as num).toInt(),
      date: dateFormat.parse(json['date']), 
      type: json['type']
    );
  }
}
