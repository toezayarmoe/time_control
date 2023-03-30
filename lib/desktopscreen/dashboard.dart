import 'package:flutter/material.dart';
import 'package:time_control/components/alltasks.dart';
import 'package:time_control/components/newtasks.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentScreen = 0;
  List<Widget> screenList = [
    const AllTasks(),
    const NewTask(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                child: ListView(
                  children: [
                    ExpansionTile(
                      backgroundColor: Colors.white,
                      title: const Text("Task"),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 0
                                ? Colors.lightBlueAccent
                                : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: ListTile(
                            title: const Text("All Tasks"),
                            onTap: () {
                              setState(() {
                                currentScreen = 0;
                              });
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 1
                                ? Colors.lightBlueAccent
                                : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: ListTile(
                            title: const Text("New Task"),
                            onTap: () {
                              setState(() {
                                currentScreen = 1;
                              });
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 2
                                ? Colors.lightBlueAccent
                                : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: const ListTile(
                            title: Text("Current Tasks"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 3
                                ? Colors.lightBlueAccent
                                : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: const ListTile(
                            title: Text("Finished Tasks"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 4
                                ? Colors.lightBlueAccent
                                : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: const ListTile(
                            title:
                                Text("logs(cancelled tasks, reassigned tasks)"),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            currentScreen == 5 ? Colors.lightBlueAccent : null,
                      ),
                      child: const ListTile(
                        title: Text("Message"),
                      ),
                    ),
                    ExpansionTile(
                      title: const Text("Staff"),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 6
                                ? Colors.lightBlueAccent
                                : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: const ListTile(
                            title: Text("Staff List"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 7
                                ? Colors.lightBlueAccent
                                : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: const ListTile(
                            title: Text("Add New Staff  "),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: const Color.fromARGB(255, 247, 247, 247),
                child: screenList[currentScreen],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
