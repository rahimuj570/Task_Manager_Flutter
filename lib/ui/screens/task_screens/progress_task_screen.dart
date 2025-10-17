import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/services/api_calller.dart';
import 'package:todo_app/data/utils/urls.dart';
import 'package:todo_app/ui/controllers/progress_task_section_provider.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});
  static const name = "progress_task_screen";

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgressTaskSectionProvider>().fetchProgressedTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Consumer<ProgressTaskSectionProvider>(
        builder: (context, progressTaskSectionProvider, child) => Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Visibility(
                visible: !progressTaskSectionProvider.isFatching,
                replacement: Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(strokeWidth: 5),
                  ),
                ),
                child: Material(
                  child: Visibility(
                    visible: progressTaskSectionProvider.getTodo.isNotEmpty,
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
                        statusColor: Colors.purple,
                        status: TaskStatus.Progress,
                        tm: progressTaskSectionProvider.getTodo[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      itemCount: progressTaskSectionProvider.getTodo.length,
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
