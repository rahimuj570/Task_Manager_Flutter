import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});
  static const name = "progress_task_screen";

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final List<TaskModel> _progressTaskList = [];
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
                  statusColor: Colors.purpleAccent,
                  tm: _progressTaskList[index],
                  status: TaskStatus.Progress,
                ),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: _progressTaskList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
