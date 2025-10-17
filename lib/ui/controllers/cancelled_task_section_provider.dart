import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/task_status.dart';

class CancelledTaskSectionProvider extends ChangeNotifier {
  //For fetch cancelled todo
  bool isFatching = false;
  final List<TaskModel> _cancelledTaskList = [];
  List<TaskModel> get getTodo => _cancelledTaskList;

  //Fetch Cancelled todo
  Future<void> fetchsCancelledTodo() async {
    _cancelledTaskList.clear();
    isFatching = true;
    notifyListeners();
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.getTodoList(TaskStatus.Cancelled.name),
    );
    if (apiResponse.isuccess == true) {
      for (Map<String, dynamic> t in apiResponse.responseData['data']) {
        TaskModel temp = TaskModel.fromJson(t);
        _cancelledTaskList.add(temp);
      }
    }
    isFatching = false;
    notifyListeners();
  }
}
