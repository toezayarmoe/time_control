import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_control/models/worker.dart';
import 'package:time_control/services/getworker.dart';
import 'package:http/http.dart' as http;

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  List b64edImgs = [];

  final taskTitleController = TextEditingController();
  final taskSummaryController = TextEditingController();
  final expectedDurationController = TextEditingController();
  final expectedCostController = TextEditingController();
  String taskTitle = '';
  String taskSummary = '';
  File? attachment;
  String assignWorker = '';
  int? expectedDuration;
  int? expectedCost;
  String? dropDownCurrentValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
            controller: taskTitleController,
            onChanged: (value) {
              taskTitle = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Task Title",
              hintText: "Task Title",
            ),
          ),
          const SizedBox(
            height: 10,
            width: double.infinity,
          ),
          TextFormField(
            controller: taskSummaryController,
            maxLines: 10,
            onChanged: (value) {
              taskSummary = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Task Summary",
              labelText: "Task Summary",
            ),
          ),
          const SizedBox(
            height: 10,
            width: double.infinity,
          ),
          Row(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(20),
                  ),
                ),
                onPressed: () async {
                  b64edImgs.clear();
                  await imagesPicker();
                  setState(() {});
                },
                child: b64edImgs.isNotEmpty
                    ? Text("${b64edImgs.length} Images Added")
                    : const Text("Add Photo"),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(20),
                  ),
                ),
                onPressed: () {
                  attachmentPicker();
                },
                child: const Text("Attachment"),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: expectedDurationController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Expected Duration",
                    hintText: "Expected Duration",
                  ),
                  onChanged: ((value) => expectedDuration = int.parse(value)),
                ),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: expectedCostController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Expected Cost",
                    hintText: "Expected Cost",
                  ),
                  onChanged: (value) {
                    expectedCost = int.parse(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          FutureBuilder<List<Worker>>(
            future: getWorker(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                return DropdownButton(
                  value: dropDownCurrentValue,
                  onChanged: (value) {
                    dropDownCurrentValue = value;
                    setState(() {});
                  },
                  hint: const Text("Assign Worker"),
                  items: data.map((value) {
                    return DropdownMenuItem(
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(20),
                  ),
                ),
                onPressed: () async {
                  debugPrint(taskTitle);
                  debugPrint(taskSummary);
                  debugPrint(expectedDuration.toString());
                  debugPrint(expectedCost.toString());
                  debugPrint(dropDownCurrentValue);
                  debugPrint("$attachment");
                  debugPrint(b64edImgs.toString());
                  await postData();
                  taskTitleController.clear();
                  taskSummaryController.clear();
                  expectedCostController.clear();
                  expectedDurationController.clear();
                  dropDownCurrentValue = null;
                },
                child: const Text("Create Task"),
              ),
            ],
          )
        ],
      ),
    );
  }

  imagesPicker() async {
    await openFiles(
      acceptedTypeGroups: [
        const XTypeGroup(label: 'image', extensions: [
          'png',
          'jpg',
          'jpeg',
        ]),
      ],
    ).then(
      (value) {
        for (int i = 0; i < value.length; i++) {
          value[i].readAsBytes().then((value) {
            b64edImgs.add({"taskImage": base64.encode(value)});
          });
        }
      },
    );
  }

  attachmentPicker() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'attachment',
      extensions: <String>['zip'],
    );
    final XFile? file = await openFile(
      acceptedTypeGroups: <XTypeGroup>[typeGroup],
    );
    attachment = File(file!.path);
  }

  Future postData() async {
    const url = 'https://hrbackend.cyclic.app/api/CreateTask';
    //final attachmentBytes = attachment!.readAsBytesSync();
    var payload = {
      'title': taskTitle,
      'worker': dropDownCurrentValue,
      'description': taskSummary,
      'taskImageList': b64edImgs,
      'expectedDurationDay': expectedDuration,
      'expectedCost': expectedCost,
      'attachment': {
        'fileName': attachment!.path.split('/').last,
        "data": await attachment!.readAsBytes()
      }
    };
    final response = await http.post(
      Uri.parse('url'),
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
