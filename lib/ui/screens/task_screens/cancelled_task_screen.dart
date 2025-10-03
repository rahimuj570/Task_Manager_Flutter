import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});
  static const name = "cancelled_task_screen";

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool isFatching = false;
  final List<TaskModel> _cancelledTaskList = [];

  Future<void> getCancelledTodo() async {
    _cancelledTaskList.clear();
    isFatching = !isFatching;
    setState(() {});
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.getTodoList(TaskStatus.Cancelled.name),
    );

    if (apiResponse.isuccess == true) {
      for (Map<String, dynamic> t in apiResponse.responseData['data']) {
        TaskModel temp = TaskModel.fromJson(t);
        _cancelledTaskList.add(temp);
      }
    }

    isFatching = !isFatching;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCancelledTodo();
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
                child: Visibility(
                  visible: _cancelledTaskList.isNotEmpty,
                  replacement: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_off, size: 200, color: Colors.green),
                        Text(
                          "No Task Found",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) => TaskTileWidget(
                      reFetch: getCancelledTodo,
                      statusColor: Colors.red,
                      status: TaskStatus.Cancelled,
                      tm: _cancelledTaskList[index],
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 5),
                    itemCount: _cancelledTaskList.length,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
