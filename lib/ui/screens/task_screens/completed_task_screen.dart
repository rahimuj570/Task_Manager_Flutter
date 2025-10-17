import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/controllers/completed_task_section_provider.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});
  static const name = "completed_task_screen";

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompletedTaskSectionProvider>().fetchCompletedTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Consumer<CompletedTaskSectionProvider>(
        builder: (context, completedTaskSectionProvider, child) {
          return Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: Visibility(
                  visible: !completedTaskSectionProvider.isFatching,
                  replacement: Center(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator(strokeWidth: 5),
                    ),
                  ),
                  child: Material(
                    child: Visibility(
                      visible: completedTaskSectionProvider.getTodo.isNotEmpty,
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
                        itemBuilder: (context, index) => TaskTileWidget(
                          statusColor: Colors.green,
                          status: TaskStatus.Completed,
                          tm: completedTaskSectionProvider.getTodo[index],
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 5),
                        itemCount: completedTaskSectionProvider.getTodo.length,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
