import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/models/task_status_count_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/task_status.dart';

class NewTaskSectionProvider extends ChangeNotifier {
  //to count todo
  bool isCounting = false;
  final Map<String, dynamic> _taskCount = {};
  Map<String, dynamic> getTaskCount() => _taskCount;
  //to fetch todo list
  bool isFatching = false;
  final List<TaskModel> _newTaskList = [];
  List<TaskModel> getTodo() => _newTaskList;

  //GET todo status count
  Future<void> getTodoStatusCount() async {
    _taskCount.clear();
    isCounting = true;
    notifyListeners();
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.getTodoCount,
    );

    if (apiResponse.isuccess == true) {
      for (Map<String, dynamic> c in apiResponse.responseData['data']) {
        TaskStatusCountModel temp = TaskStatusCountModel.fromJson(c);
        _taskCount[temp.status] = temp.count;
      }
    }
    isCounting = false;
    notifyListeners();
  }

  //Fetch todod list
  Future<void> fetchNewTodo() async {
    _newTaskList.clear();
    isFatching = true;
    notifyListeners();
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.getTodoList(TaskStatus.New.name),
    );
    if (apiResponse.isuccess == true) {
      for (Map<String, dynamic> t in apiResponse.responseData['data']) {
        TaskModel temp = TaskModel.fromJson(t);
        _newTaskList.add(temp);
      }
    }
    isFatching = false;
    notifyListeners();
  }
}
