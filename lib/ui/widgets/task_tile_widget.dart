import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/show_toast.dart';

class TaskTileWidget extends StatefulWidget {
  const TaskTileWidget({
    super.key,
    required this.tm,
    required this.status,
    required this.statusColor,
    required this.reFetch,
    this.reCount,
  });

  final TaskStatus status;
  final Color statusColor;
  final TaskModel tm;
  final VoidCallback reFetch;
  final VoidCallback? reCount;

  @override
  State<TaskTileWidget> createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  bool isUpdating = false;
  bool isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        widget.tm.title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.tm.description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().add_jm().format(
              DateTime.parse(widget.tm.createdDate),
            ),
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
                  color: widget.statusColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                child: Text(
                  widget.status.name,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Row(
                spacing: 8,
                children: [
                  Visibility(
                    visible: !isUpdating,
                    replacement: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.blueAccent,
                      ),
                    ),
                    child: PopupMenuButton(
                      color: Colors.green[50],
                      tooltip: 'Change Status',
                      onSelected: (value) => _changeStatus(value),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          enabled: widget.status != TaskStatus.New,
                          value: TaskStatus.New,
                          child: Text("New"),
                        ),
                        PopupMenuItem(
                          enabled: widget.status != TaskStatus.Completed,
                          value: TaskStatus.Completed,
                          child: Text("Complete"),
                        ),
                        PopupMenuItem(
                          value: TaskStatus.Cancelled,
                          enabled: widget.status != TaskStatus.Cancelled,
                          child: Text("Cancel"),
                        ),
                        PopupMenuItem(
                          enabled: widget.status != TaskStatus.Progress,
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
                  ),
                  Visibility(
                    visible: !isDeleting,
                    replacement: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.red,
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      iconSize: 20,
                      onPressed: deleteTask,
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
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
    setState(() {
      isUpdating = !isUpdating;
    });
    debugPrint(widget.tm.id);
    debugPrint(status.name);
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.updatestatus(todoId: widget.tm.id, status: status.name),
    );

    if (apiResponse.isuccess) {
      showSnackBar(context, "Successfully status changed!", ToastType.success);
      widget.reFetch();
      if (widget.reCount != null) {
        widget.reCount!();
      }
    } else {
      showSnackBar(context, "Something Went Wrong", ToastType.error);
    }
    setState(() {
      isUpdating = !isUpdating;
    });
  }

  Future<void> deleteTask() async {
    setState(() {
      isDeleting = true;
    });
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.deleteTaskById(widget.tm.id),
    );
    if (apiResponse.isuccess) {
      showSnackBar(context, "Successfully Deleted", ToastType.success);
      widget.reFetch();
    } else {
      showSnackBar(context, "Failed to deletes", ToastType.error);
    }
    setState(() {
      isDeleting = false;
    });
  }
}
