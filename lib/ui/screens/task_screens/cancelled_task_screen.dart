import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});
  static const name = "cancelled_task_screen";

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final List<TaskModel> _canceledTaskList = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Material(
              child: ListView.separated(
                itemBuilder: (context, index) => TaskTileWidget(
                  tm: _canceledTaskList[index],
                  statusColor: Colors.red,
                  status: TaskStatus.Cancelled,
                ),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: _canceledTaskList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
