import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_control/models/worker.dart';
import 'package:time_control/services/addtask.dart';
import 'package:time_control/services/getworker.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  List<Map<String, String>> b64edImgs = [];

  final taskTitleController = TextEditingController();
  final taskSummaryController = TextEditingController();
  final expectedDurationController = TextEditingController();
  final expectedCostController = TextEditingController();
  String taskTitle = '';
  String taskSummary = '';
  XFile? attachment;
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
                  setState(() {
                    debugPrint("Added Image");
                  });
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
                onPressed: () async {
                  await attachmentPicker();
                  setState(() {});
                },
                child: attachment == null
                    ? const Text("Attachment")
                    : const Text("1 Attachment"),
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
                  debugPrint("Somebody Click Me");
                  debugPrint(taskTitle);
                  debugPrint(taskSummary);
                  debugPrint(expectedDuration.toString());
                  debugPrint(expectedCost.toString());
                  debugPrint(dropDownCurrentValue);
                  debugPrint("Attachment $attachment");
                  debugPrint("imagelist ${b64edImgs.toString()}");
                  await AddTask(
                    taskTitle: taskTitle,
                    workerName: dropDownCurrentValue!,
                    description: taskSummary,
                    imageList: b64edImgs,
                    expectedDuration: expectedDuration!,
                    expectedCost: expectedCost!,
                    attachment: attachment!,
                  ).postData();

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
            print(value);
            b64edImgs.add(
              {
                "taskImage": base64.encode(value),
              },
            );
            print(b64edImgs);

            // b64edImgs!.add(
            //   {
            //     "taskImage": base64.encode(value),
            //   },
            // );
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
    attachment = file;
  }
}
