import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charity_app/home/model/donation_model.dart';

class DonationRepositry {
final String url = '';
  Future<List<projectModel>> fetchProjects() async {

    final response = await http.get(Uri.parse(url));
    // ignore: avoid_print
    print('Response status: ${response.statusCode}');
    // ignore: avoid_print
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {

      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => projectModel.fromJson(e)).toList();
    }
     else {
      throw Exception("فشل في جلب المشاريع");
    }
  }
}
