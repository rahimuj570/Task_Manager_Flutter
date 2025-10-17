import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/controllers/new_task_section_provider.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';
import 'package:todo_app/ui/widgets/top_status_card_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});
  static const name = "new_task_screen";

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    NewTaskSectionProvider newTaskSectionProvider = context
        .read<NewTaskSectionProvider>();
    newTaskSectionProvider.getTodoStatusCount();
    newTaskSectionProvider.fetchNewTodo();
  }

  @override
  Widget build(BuildContext context) {
    // getNewTodo();
    return Consumer<NewTaskSectionProvider>(
      builder: (context, newTaskSectionProvider, child) => Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Column(
          children: [
            Visibility(
              visible: !newTaskSectionProvider.isCounting,
              replacement: CircularProgressIndicator(strokeWidth: 5),
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TopStatusCardWidget(
                      label: 'Cancelled',
                      count:
                          newTaskSectionProvider.getTaskCount()['Cancelled'] ??
                          0,
                    ),
                  ),
                  Expanded(
                    child: TopStatusCardWidget(
                      label: 'Completed',
                      count:
                          newTaskSectionProvider.getTaskCount()['Completed'] ??
                          0,
                    ),
                  ),
                  Expanded(
                    child: TopStatusCardWidget(
                      label: 'Progress',
                      count:
                          newTaskSectionProvider.getTaskCount()['Progress'] ??
                          0,
                    ),
                  ),
                  Expanded(
                    child: TopStatusCardWidget(
                      label: 'New Tasks',
                      count: newTaskSectionProvider.getTaskCount()['New'] ?? 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Visibility(
              visible: !newTaskSectionProvider.isFatching,
              replacement: Expanded(
                child: Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(strokeWidth: 5),
                  ),
                ),
              ),
              child: Expanded(
                child: Material(
                  child: Visibility(
                    visible: newTaskSectionProvider.getTodo().isNotEmpty,
                    replacement: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_off,
                            size: 200,
                            color: Colors.green,
                          ),
                          Text(
                            "No Task Found",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        if (index == newTaskSectionProvider.getTodo().length) {
                          return SizedBox(height: 70);
                        }
                        return TaskTileWidget(
                          tm: newTaskSectionProvider.getTodo()[index],
                          statusColor: Colors.cyan,
                          status: TaskStatus.New,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      itemCount: newTaskSectionProvider.getTodo().length + 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
