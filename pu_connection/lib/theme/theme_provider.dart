import 'package:flutter/material.dart';

import 'theme_controller.dart';

class ThemeProvider extends InheritedWidget {
  final ThemeManager manager;

  const ThemeProvider({
    Key? key,
    required this.manager,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return manager != oldWidget.manager;
  }
}
