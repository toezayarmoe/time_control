class Task {
  final String id;
  final String title;
  final String worker;
  final int expectedDurationDay;
  final DateTime createdAt;
  final int remainingDay;
  Task({
    required this.id,
    required this.title,
    required this.worker,
    required this.expectedDurationDay,
    required this.createdAt,
    required this.remainingDay,
  });
  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json['_id'],
      title: json['title'],
      worker: json['worker'],
      expectedDurationDay: json['expectedDurationDay'],
      createdAt: DateTime.parse(json['createdAt']),
      remainingDay: json['remainingDay'],
    );
  }
}
