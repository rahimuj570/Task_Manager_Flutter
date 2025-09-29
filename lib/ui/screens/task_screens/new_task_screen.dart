import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_status_count_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';
import 'package:todo_app/ui/widgets/top_status_card_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static const name = "new_task_screen";

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isCounting = false;
  Map<String, dynamic> _taskCount = {};

  Future<void> getTodoStatusCount() async {
    isCounting = !isCounting;
    setState(() {});
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.getTodoCount,
    );

    if (apiResponse.isuccess == true) {
      for (Map<String, dynamic> c in apiResponse.responseData['data']) {
        TaskStatusCountModel temp = TaskStatusCountModel.fromJson(c);
        _taskCount[temp.status] = temp.count;
      }
    }

    isCounting = !isCounting;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodoStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Column(
        children: [
          Visibility(
            visible: !isCounting,
            replacement: CircularProgressIndicator(strokeWidth: 5),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TopStatusCardWidget(
                    label: 'Cancelled',
                    count: _taskCount['Cancelled'] ?? 0,
                  ),
                ),
                Expanded(
                  child: TopStatusCardWidget(
                    label: 'Completed',
                    count: _taskCount['Completed'] ?? 0,
                  ),
                ),
                Expanded(
                  child: TopStatusCardWidget(
                    label: 'Progress',
                    count: _taskCount['Progress'] ?? 0,
                  ),
                ),
                Expanded(
                  child: TopStatusCardWidget(
                    label: 'New Tasks',
                    count: _taskCount['New'] ?? 0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Material(
              child: ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    print(index);
                    return SizedBox(height: 70);
                  }
                  return TaskTileWidget(
                    statusColor: Colors.cyan,
                    status: 'new',
                    deleteFunc: (int id) =>
                        () => _deleteFunc(id),

                    editFunc: (int id) =>
                        () => _editFunc(id),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editFunc(int i) {
    print("ed");
  }

  void _deleteFunc(int i) {
    print("del");
  }
}
