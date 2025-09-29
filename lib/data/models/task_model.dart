class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String email;
  final String createdDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.email,
    required this.createdDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> body) {
    return TaskModel(
      id: body['_id'],
      title: body['title'],
      description: body['description'],
      status: body['status'],
      email: body['email'],
      createdDate: body['createdDate'],
    );
  }

  static Map<String, dynamic> toJson(TaskModel tm) {
    return {
      "_id": tm.id,
      "title": tm.title,
      "description": tm.description,
      "status": tm.status,
      "email": tm.email,
      "createdDate": tm.createdDate,
    };
  }

  //  "_id": "68d9409527e751dc7aeb0463",
  //           "title": "A",
  //           "description": "v",
  //           "status": "New",
  //           "email": "tt@tt.tt",
  //           "createdDate": "2025-09-24T06:37:47.856Z"
}
