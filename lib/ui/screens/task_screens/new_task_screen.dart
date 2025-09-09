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
  bool _isAtBottom = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isAtBottom =
            _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 10;
        print(_scrollController.position.pixels);
      });
    });
  }

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
                itemBuilder: (context, index) => TaskTileWidget(),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: 10,
              ),
            ),
          ),
          AnimatedPadding(
            padding: EdgeInsets.only(bottom: _isAtBottom ? 70 : 0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
