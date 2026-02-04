import 'package:file_sharing_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? label;
  final String? hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final double borderRadius;
  final double verticalHeight;
  final double horizontalHeight;
  final Widget? prefixIcon;
  final Widget? suffixIcons;
  final int? maxLines;
  final int? maxLength;
  final TextAlignVertical? textAlignVertical;

  const CustomTextFieldWidget({
    super.key,
    this.label,
    this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.borderRadius = 20,
    this.verticalHeight = 12,
    this.horizontalHeight = 20,
    this.prefixIcon,
    this.suffixIcons,
    this.maxLines,
    this.maxLength,
    this.textAlignVertical,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: screenWidth(context, dividedBy: 1.1),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.lightBlue,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: obscureText ? 1 : maxLines,
        maxLength: maxLength,
        textAlignVertical: textAlignVertical,
        style: const TextStyle(fontSize: 13, height: 1.2),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcons != null
              ? Row(mainAxisSize: MainAxisSize.min, children: [suffixIcons!])
              : null,
          hintText: hint,
          border: null,
          isDense: true,
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalHeight,
            vertical: verticalHeight,
          ),

          hintStyle: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontSize: 13),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.lightBlue),
          ),
        ),
      ),
    );
  }
}
