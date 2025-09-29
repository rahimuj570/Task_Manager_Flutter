class TaskStatusCountModel {
  final String status;
  final int count;

  TaskStatusCountModel({required this.status, required this.count});

  factory TaskStatusCountModel.fromJson(Map<String, dynamic> body) {
    return TaskStatusCountModel(status: body['_id'], count: body['sum']);
  }

  static Map<String, dynamic> toJson(TaskStatusCountModel tc) {
    return {"_id": tc.status, "sum": tc.count};
  }
}
