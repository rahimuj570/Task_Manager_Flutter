import 'package:flutter/material.dart';

class CustomNavbarWidget extends StatelessWidget {
  final int selectedDestination;
  final Function(int) clickDestination;

  const CustomNavbarWidget({
    super.key,
    required this.clickDestination,
    required this.selectedDestination,
  });

  final List<_NavItem> items = const [
    _NavItem(icon: Icons.note_add, label: 'New Task', color: Colors.green),
    _NavItem(icon: Icons.check_circle, label: 'Completed', color: Colors.green),
    _NavItem(icon: Icons.cancel, label: 'Canceled', color: Colors.green),
    _NavItem(icon: Icons.timelapse, label: 'Progress', color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          return Expanded(
            child: InkWell(
              onTap: () => clickDestination(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selectedDestination == index
                      ? Colors.green
                      : Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index].icon,
                      color: selectedDestination == index
                          ? Colors.white
                          : Colors.black,
                    ),
                    SizedBox(height: 2),
                    Text(
                      items[index].label,
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedDestination == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final Color color;

  const _NavItem({
    required this.color,
    required this.icon,
    required this.label,
  });
}
