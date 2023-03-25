import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_control/models/task.dart';

Future<List<Task>> getTasks() async {
  final response = await http.get(Uri.parse("https://hrbackend.cyclic.app/api/GetTasks"));
  if (response.statusCode == 200){
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Task.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load tasks');
  }
}