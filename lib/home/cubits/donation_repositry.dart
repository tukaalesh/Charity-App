import 'dart:convert';
import 'package:charity_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:charity_app/home/model/donation_model.dart';

class DonationRepositry {
  final String url = '$baseUrl/api/donor/home';

  Future<List<DonationModel>> fetchProjects() async {
    final token = sharedPreferences.get('token');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => DonationModel.fromJson(e)).toList();
    } else {
      throw Exception("فشل في جلب المشاريع");
    }
  }
}
