import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/model/lead_model.dart';

Future<List<Estimate>> fetchLeads() async {
  final response = await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final estimatesJson = data['Customer_Estimate_Flow'] as List;
    return estimatesJson.map((json) => Estimate.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load estimates');
  }
}
