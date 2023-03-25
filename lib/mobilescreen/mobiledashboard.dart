import 'package:flutter/material.dart';
import 'package:time_control/components/alltasks.dart';
import 'package:time_control/components/newtasks.dart';

class MobileDashboard extends StatefulWidget {
  const MobileDashboard({super.key});

  @override
  State<MobileDashboard> createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
  List<Widget> screenList = [
    const AllTasks(),
    const NewTask(),
  ];
  int currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All tasks"),
        ),
        body: screenList[currentScreen],
        drawer: Drawer(
          child: ListView(
                  children: [
                    ExpansionTile(
                      backgroundColor: Colors.white,
                      title: const Text("Task"),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 0 ? Colors.lightBlueAccent : null,
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
                            color: currentScreen == 1 ? Colors.lightBlueAccent : null,
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
                            color: currentScreen == 2 ? Colors.lightBlueAccent : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: const ListTile(
                            title: Text("Current Tasks"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 3 ? Colors.lightBlueAccent : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: const ListTile(
                            title: Text("Finished Tasks"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 4 ? Colors.lightBlueAccent : null,
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
                            color: currentScreen == 5? Colors.lightBlueAccent : null,
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
                            color: currentScreen == 6 ? Colors.lightBlueAccent : null,
                          ),
                          padding: const EdgeInsets.only(left: 15),
                          child: const ListTile(
                            title: Text("Staff List"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: currentScreen == 7 ? Colors.lightBlueAccent : null,
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
    );
  }
}