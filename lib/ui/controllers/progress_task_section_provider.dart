import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/task_status.dart';

class ProgressTaskSectionProvider extends ChangeNotifier {
  //For fetch progess todo
  bool isFatching = false;
  final List<TaskModel> _progressedTaskList = [];
  List<TaskModel> get getTodo => _progressedTaskList;

  //Fetch progress todo
  Future<void> fetchProgressedTodo() async {
    _progressedTaskList.clear();
    isFatching = !isFatching;
    notifyListeners();
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.getTodoList(TaskStatus.Progress.name),
    );

    if (apiResponse.isuccess == true) {
      for (Map<String, dynamic> t in apiResponse.responseData['data']) {
        TaskModel temp = TaskModel.fromJson(t);
        _progressedTaskList.add(temp);
      }
    }

    isFatching = !isFatching;
    notifyListeners();
  }

  void removeTodoFromList(String id) {
    _progressedTaskList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
