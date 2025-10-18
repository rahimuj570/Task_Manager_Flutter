import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/controllers/cancelled_task_section_provider.dart';
import 'package:todo_app/ui/controllers/completed_task_section_provider.dart';
import 'package:todo_app/ui/controllers/new_task_section_provider.dart';
import 'package:todo_app/ui/controllers/progress_task_section_provider.dart';
import 'package:todo_app/ui/utils/task_status.dart';

class TaskStatusChangeController {
  //Change Task Status
  static Future<bool> changeStatus(
    String oldStatus,
    TaskStatus newStatus,
    String taskId,
    BuildContext context,
  ) async {
    bool success = false;
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.updatestatus(todoId: taskId, status: newStatus.name),
    );
    if (apiResponse.isuccess) {
      success = true;
      refreshList(
        newStatus: newStatus.name,
        oldStatus: oldStatus,
        context: context,
        taskId: taskId,
      );
    }
    return success;
  }

  //Delete Task
  static Future<bool> deleteTask(
    String status,
    String taskId,
    BuildContext context,
  ) async {
    bool success = false;
    ApiResponse apiResponse = await ApiCalller.getRequest(
      url: Urls.deleteTaskById(taskId),
    );
    if (apiResponse.isuccess) {
      success = true;
      refreshList(oldStatus: status, context: context, taskId: taskId);
    }
    return success;
  }

  //Refresh List of Tasks
  static void refreshList({
    String? newStatus,
    required String oldStatus,
    required BuildContext context,
    required String taskId,
  }) {
    if (oldStatus == "New") {
      context.read<NewTaskSectionProvider>().removeTodoFromList(taskId);
      context.read<NewTaskSectionProvider>().increaseTodoStatusCountBy1(
        newStatus!,
      );
    } else if (oldStatus == "Progress") {
      context.read<ProgressTaskSectionProvider>().removeTodoFromList(taskId);
    } else if (oldStatus == "Completed") {
      context.read<CompletedTaskSectionProvider>().removeTodoFromList(taskId);
    } else if (oldStatus == "Cancelled") {
      context.read<CancelledTaskSectionProvider>().removeTodoFromList(taskId);
    }
  }
}
