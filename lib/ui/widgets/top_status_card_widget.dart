import 'package:flutter/material.dart';

class TopStatusCardWidget extends StatelessWidget {
  final String label;
  final int count;
  const TopStatusCardWidget({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
