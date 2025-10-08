import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/state%20management/tm_app_bar_notifier.dart';

class AppbarInheritedWidget extends InheritedWidget {
  const AppbarInheritedWidget({
    super.key,
    required super.child,
    required this.tmAppBarInfoNotifier,
  });
  final TmAppBarInfoNotifier tmAppBarInfoNotifier;

  @override
  bool updateShouldNotify(AppbarInheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    // TmAppBarInfoNotifier old = oldWidget.tmAppBarInfoNotifier;
    return true;
  }

  static AppbarInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppbarInheritedWidget>();
  }
}
