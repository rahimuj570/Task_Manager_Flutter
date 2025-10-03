import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});
  static const name = "completed_task_screen";

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool isFatching = false;
  final List<TaskModel> _completedTaskList = [];

  Future<void> getCompletedTodo() async {
    _completedTaskList.clear();
    isFatching = !isFatching;
    setState(() {});
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.getTodoList(TaskStatus.Completed.name),
    );

    if (apiResponse.isuccess == true) {
      for (Map<String, dynamic> t in apiResponse.responseData['data']) {
        TaskModel temp = TaskModel.fromJson(t);
        _completedTaskList.add(temp);
      }
    }

    isFatching = !isFatching;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCompletedTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Visibility(
              visible: !isFatching,
              replacement: Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(strokeWidth: 5),
                ),
              ),
              child: Material(
                child: ListView.separated(
                  itemBuilder: (context, index) => TaskTileWidget(
                    reFetch: getCompletedTodo,
                    statusColor: Colors.green,
                    status: TaskStatus.Completed,
                    tm: _completedTaskList[index],
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemCount: _completedTaskList.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
