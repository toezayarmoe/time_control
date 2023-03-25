import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_control/models/task.dart';

String url = "https://hrbackend.cyclic.app/api/GetTasks";

Future<List<Task>> getTasks() async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Task.fromJson(json)).toList();
  }
  throw Exception('Failed to load tasks');
}
