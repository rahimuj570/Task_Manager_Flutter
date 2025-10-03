import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/ui/utils/task_status.dart';

class TaskTileWidget extends StatelessWidget {
  const TaskTileWidget({
    super.key,
    required this.tm,
    required this.status,
    required this.statusColor,
  });

  final TaskStatus status;
  final Color statusColor;
  final TaskModel tm;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        tm.title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tm.description, style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: 8),
          Text(
            tm.createdDate,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 10,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                child: Text(
                  status.name,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Row(
                spacing: 8,
                children: [
                  PopupMenuButton(
                    color: Colors.green[50],
                    tooltip: 'Select Action',
                    onSelected: (value) => _changeStatus(value),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        enabled: status != TaskStatus.New,
                        value: TaskStatus.New,
                        child: Text("New"),
                      ),
                      PopupMenuItem(
                        enabled: status != TaskStatus.Completed,
                        value: TaskStatus.Completed,
                        child: Text("Complete"),
                      ),
                      PopupMenuItem(
                        value: TaskStatus.Cancelled,
                        enabled: status != TaskStatus.Cancelled,
                        child: Text("Cancel"),
                      ),
                      PopupMenuItem(
                        enabled: status != TaskStatus.Progress,
                        value: TaskStatus.Progress,
                        child: Text("Progress"),
                      ),
                    ],
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      iconSize: 20,
                      onPressed: null,
                      icon: Icon(Icons.edit),
                      disabledColor: Colors.blue,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    iconSize: 20,
                    onPressed: null,
                    icon: Icon(Icons.delete),
                    disabledColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _changeStatus(TaskStatus status) async {
    debugPrint(tm.id);
    debugPrint(status.name);
    if (status == TaskStatus.New) {
    } else if (status == TaskStatus.Completed) {
    } else if (status == TaskStatus.Cancelled) {
    } else {}
  }
}
