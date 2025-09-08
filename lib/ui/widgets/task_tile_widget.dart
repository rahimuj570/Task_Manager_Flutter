import 'package:flutter/material.dart';

class TaskTileWidget extends StatelessWidget {
  const TaskTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        "data",
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "sssssss s  s s  s s  s s",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 8),
          Text(
            "02/9/2025",
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
                  color: Colors.cyan,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                child: Text(
                  "new",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Row(
                spacing: 8,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    iconSize: 20,
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    iconSize: 20,
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
