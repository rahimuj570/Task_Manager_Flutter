import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/models/task_status_count_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/task_status.dart';

class NewTaskSectionProvider extends ChangeNotifier {
  //for count todo
  bool isCounting = false;
  final Map<String, dynamic> _taskCount = {};
  Map<String, dynamic> getTaskCount() => _taskCount;
  //for fetch todo list
  bool isFatching = false;
  final List<TaskModel> _newTaskList = [];
  List<TaskModel> getTodo() => _newTaskList;
  //for create new todo
  bool isCreating = false;
  String? _errorMessage;
  String? get getErrorMessage => _errorMessage;

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

  //Create new todo
  Future<bool> createTodo(String subject, String description) async {
    _errorMessage = null;
    bool success = false;
    isCreating = true;
    notifyListeners();
    Map<String, dynamic> body = {
      "title": subject,
      "description": description,
      "status": "New",
    };
    ApiResponse apiResponse = await ApiCalller.postRequest(
      url: Urls.createTodo,
      body: body,
    );
    if (apiResponse.isuccess) {
      success = true;
      _newTaskList.add(TaskModel.fromJson(apiResponse.responseData['data']));
      _taskCount[TaskStatus.New.name] =
          _taskCount[TaskStatus.New.name] ?? 0 + 1;
    } else {
      _errorMessage = apiResponse.errorMessage.toString();
    }
    isCreating = false;
    notifyListeners();
    return success;
  }

  void removeTodoFromList(String id) {
    _newTaskList.removeWhere((element) => element.id == id);
    notifyListeners();
    _taskCount[TaskStatus.New.name] = _taskCount[TaskStatus.New.name] - 1;
  }

  void increaseTodoStatusCountBy1(String status) {
    _taskCount[status] = _taskCount[status] ?? 0 + 1;
  }
}
