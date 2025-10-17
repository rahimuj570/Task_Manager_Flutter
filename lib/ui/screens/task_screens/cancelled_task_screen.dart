import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/controllers/cancelled_task_section_provider.dart';
import 'package:todo_app/ui/utils/task_status.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});
  static const name = "cancelled_task_screen";

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CancelledTaskSectionProvider>().fetchsCancelledTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CancelledTaskSectionProvider>(
      builder: (context, cancelledTaskScreen, child) => Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Visibility(
                visible: !cancelledTaskScreen.isFatching,
                replacement: Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(strokeWidth: 5),
                  ),
                ),
                child: Material(
                  child: Visibility(
                    visible: cancelledTaskScreen.getTodo.isNotEmpty,
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
                        statusColor: Colors.red,
                        status: TaskStatus.Cancelled,
                        tm: cancelledTaskScreen.getTodo[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      itemCount: cancelledTaskScreen.getTodo.length,
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
