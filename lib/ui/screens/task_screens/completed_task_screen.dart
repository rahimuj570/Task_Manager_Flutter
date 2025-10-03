import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});
  static const name = "completed_task_screen";

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final List<TaskModel> _completedTaskList = [];
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
                  statusColor: Colors.green,
                  status: TaskStatus.Completed,
                  tm: _completedTaskList[index],
                ),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: _completedTaskList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
