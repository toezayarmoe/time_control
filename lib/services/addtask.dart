import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTask {
  late String taskTitle;
  late String workerName;
  late String description;
  late List imageList;
  late int expectedDuration;
  late int expectedCost;
  XFile attachment;
  AddTask({
    required this.taskTitle,
    required this.workerName,
    required this.description,
    required this.imageList,
    required this.expectedDuration,
    required this.expectedCost,
    required this.attachment,
  });
  Future postData() async {
    const url = 'https://hrbackend.cyclic.app/api/CreateTask';
    var payload = {
      'title': taskTitle,
      'worker': workerName,
      'description': description,
      'taskImageList': imageList,
      'expectedDurationDay': expectedDuration,
      'expectedCost': expectedCost,
      'attachment': {
        'fileName': attachment.path.split('/').last,
        "data": await attachment.readAsBytes()
      }
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(payload),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      debugPrint(
          'Task data sent successfully: Response Code: ${response.statusCode}');
    } else {
      debugPrint(
          'Failed to send task data. Error code: ${response.statusCode}');
    }
  }
}
