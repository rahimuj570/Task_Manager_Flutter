import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/task_status.dart';

class CompletedTaskSectionProvider extends ChangeNotifier {
  //For Fetch completed todo
  bool isFatching = false;
  final List<TaskModel> _completedTaskList = [];
  List<TaskModel> get getTodo => _completedTaskList;

  //Fetch Completed todo
  Future<void> fetchCompletedTodo() async {
    _completedTaskList.clear();
    isFatching = true;
    notifyListeners();
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.getTodoList(TaskStatus.Completed.name),
    );
    if (apiResponse.isuccess == true) {
      for (Map<String, dynamic> t in apiResponse.responseData['data']) {
        TaskModel temp = TaskModel.fromJson(t);
        _completedTaskList.add(temp);
      }
    }
    isFatching = false;
    notifyListeners();
  }
}
