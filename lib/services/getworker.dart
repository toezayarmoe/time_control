import 'dart:convert';

import 'package:time_control/models/worker.dart';
import 'package:http/http.dart' as http;

String url = "https://hrbackend.cyclic.app/api/GetWorkers";

Future<List<Worker>> getWorker() async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((json) => Worker.fromJson(json)).toList();
  }
  throw Exception("Fail to get Wroker");
}
