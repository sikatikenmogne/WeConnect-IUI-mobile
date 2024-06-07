import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:we_connect_iui_mobile/src/constants/app_color.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final IconData? leading;
  final Widget? title;
  final double? titleSpacing;
  final List<Widget>? actions;
  // final Color backgroundColor;
  final double width;
  final double height;

  const AppHeader({
    Key? key,
    this.leading = Icons.menu,
    this.title,
    this.titleSpacing,
    this.actions,
    // this.backgroundColor = AppColor.header,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        titleSpacing: titleSpacing,
        leading: (leading != null)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .04),
                child: IconButton(
                  icon: Icon(leading ?? Icons.menu,
                      color: AppColor.black, size: height / width * 20),
                  onPressed: () {},
                ),
              )
            : null,
        title: title,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (actions == null) ? width * .04 : width * .08),
            child: Row(
              children: actions ??
                  [
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: AppColor.black,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: AppColor.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
            ),
          ),
        ]);
  }
}
