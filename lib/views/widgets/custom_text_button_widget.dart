import 'package:file_sharing_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? color;

  const CustomTextButtonWidget({
    super.key,
    this.onPressed,
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text ?? "",
        style: TextStyle(fontSize: 18, color: color ?? AppColors.black),
      ),
    );
  }
}
