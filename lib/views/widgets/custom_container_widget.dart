import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';

class CustomContainerWidget extends StatelessWidget {
  final String img;
  final Color? backgroundColor;
  final Color? imageColor;
  final String? text;
  final Color? textColor;
  final void Function()? onTap;

  const CustomContainerWidget({
    super.key,
    required this.img,
    this.backgroundColor,
    this.imageColor,
    this.text,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 120,
            height: 100,
            color: AppColors.lightBlue,
            alignment: Alignment.center,
            child: Image.asset(
              img,
              height: 60,
              width: 60,
              color: AppColors.white,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          text ?? "",
          style: GoogleFonts.inter(
            color: AppColors.lightBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
