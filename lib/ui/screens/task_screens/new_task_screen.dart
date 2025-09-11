import 'package:flutter/material.dart';
import 'package:todo_app/ui/widgets/task_tile_widget.dart';
import 'package:todo_app/ui/widgets/top_status_card_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TopStatusCardWidget(label: 'Cancelled', count: 0),
              ),
              Expanded(
                child: TopStatusCardWidget(label: 'Completed', count: 0),
              ),
              Expanded(child: TopStatusCardWidget(label: 'Progress', count: 0)),
              Expanded(
                child: TopStatusCardWidget(label: 'New Tasks', count: 0),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: Material(
              child: ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    print(index);
                    return SizedBox(height: 70);
                  }
                  return TaskTileWidget(
                    statusColor: Colors.cyan,
                    status: 'new',
                    deleteFunc: (int id) =>
                        () => _deleteFunc(id),

                    editFunc: (int id) =>
                        () => _editFunc(id),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editFunc(int i) {
    print("ed");
  }

  void _deleteFunc(int i) {
    print("del");
  }
}
