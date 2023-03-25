class Worker {
  final String id;
  final String name;

  Worker({
    required this.id,
    required this.name,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['_id'],
      name: json['name'],
    );
  }
}
