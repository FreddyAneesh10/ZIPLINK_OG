import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? prefixIconColor;
  final Color? appBarColor;
  final void Function()? onPressed;
  final Widget? leading;
  final bool showBottomBorder;
  final bool? isCenter;

  const CustomAppBarWidget({
    super.key,
    this.title,
    this.prefixIconColor,
    this.appBarColor,
    this.onPressed,
    this.leading,
    this.showBottomBorder = false,
    this.action,
    this.isCenter,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading,
      title: title,
      centerTitle: isCenter,
      actions: action != null ? [action!] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
