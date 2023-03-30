import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_control/models/task.dart';
import 'package:time_control/constants/restapi.dart' as restapi;

String url = restapi.url + restapi.getTasks;

Future<List<Task>> getTasks() async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Task.fromJson(json)).toList();
  }
  throw Exception('Failed to load tasks');
}
