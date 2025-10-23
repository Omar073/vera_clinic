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

  double get _appBarHeight {
    final bool isMultiLine = title != null && title!.contains('\n');
    return isMultiLine ? 80.0 : kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    Widget titleContent;
    if (titleWidget != null) {
      titleContent = titleWidget!;
    } else if (title != null) {
      final titleParts = title!.split('\n');
      if (titleParts.length > 1) {
        final List<Widget> titleWidgets = [];
        for (var i = 0; i < titleParts.length; i++) {
          titleWidgets.add(Text(titleParts[i], textAlign: TextAlign.center));
          if (i < titleParts.length - 1) {
            titleWidgets.add(const SizedBox(height: 4.0));
          }
        }
        titleContent = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: titleWidgets,
        );
      } else {
        titleContent = Text(title!, textAlign: TextAlign.center);
      }
    } else {
      titleContent = const SizedBox.shrink();
    }

    return AppBar(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: titleContent,
      ),
      centerTitle: true,
      backgroundColor: backgroundColor ?? Colors.white,
      surfaceTintColor: backgroundColor ?? Colors.white,
      actions: actions,
      toolbarHeight: _appBarHeight,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}
