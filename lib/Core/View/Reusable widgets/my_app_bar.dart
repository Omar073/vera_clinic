import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const MyAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.backgroundColor,
  }) : assert(title == null || titleWidget == null,
            'Cannot provide both a title and a titleWidget');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? Text(title!),
      centerTitle: true,
      backgroundColor: backgroundColor ?? Colors.white,
      surfaceTintColor: backgroundColor ?? Colors.white,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
