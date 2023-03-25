import 'package:flutter/material.dart';
import 'package:time_control/models/task.dart';
import 'package:time_control/services/gettasks.dart' as gettasks;

class AllTasks extends StatefulWidget {
  const AllTasks({super.key});

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  late Future<List<Task>> getTasks;
  @override
  void initState() {
    super.initState();
    getTasks = gettasks.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: getTasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width < 600 ? 600 : 330,
              mainAxisExtent: 350,
              // crossAxisSpacing: 4,
              // mainAxisSpacing: 5,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Container(
                margin:  EdgeInsets.only(
                    left: 10, right: MediaQuery.of(context).size.width < 600 ? 10 : 5, top: 10, bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 0.5,
                      blurRadius: 3.0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextOnCard(data: snapshot.data![index].title),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: TextOnCard(
                          data: snapshot.data![index].worker,
                        )),
                        const SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        const Expanded(
                            child: TextOnCard(data: "Still Processing")),
                      ],
                    ),
                    TextOnCard(
                        data:
                            "Expected : ${snapshot.data![index].expectedDurationDay} Days"),
                    TextOnCard(
                        data: "Remaining : ${snapshot.data![index].remainingDay} Days"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Edit"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 35,
                            child: ElevatedButton(
                                onPressed: () {}, child: const Text("Message")),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasData) {
          return Text('${snapshot.error}');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class TextOnCard extends StatelessWidget {
  const TextOnCard({
    super.key,
    required this.data,
  });
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      //padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 150),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueAccent)),
      child: Center(
          child: Text(
        data,
      )),
    );
  }
}
