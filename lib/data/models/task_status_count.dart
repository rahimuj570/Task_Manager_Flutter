class TaskStatusCount {
  final String status;
  final int count;

  TaskStatusCount({required this.status, required this.count});

  factory TaskStatusCount.fromJson(Map<String, dynamic> body) {
    return TaskStatusCount(status: body['_id'], count: body['sum']);
  }

  static Map<String, dynamic> toJson(TaskStatusCount tc) {
    return {"_id": tc.status, "sum": tc.count};
  }
}
