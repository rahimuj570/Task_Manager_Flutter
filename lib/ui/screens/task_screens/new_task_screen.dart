import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/top_status_card_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TopStatusCardWidget(label: 'Cancelled', count: 0),
                ),
                Expanded(
                  child: TopStatusCardWidget(label: 'Completed', count: 0),
                ),
                Expanded(
                  child: TopStatusCardWidget(label: 'Progress', count: 0),
                ),
                Expanded(
                  child: TopStatusCardWidget(label: 'New Tasks', count: 0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
