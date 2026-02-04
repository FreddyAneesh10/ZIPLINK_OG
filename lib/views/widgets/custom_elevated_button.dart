import 'package:file_sharing_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const CustomElevatedButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: screenWidth(context, dividedBy: 1.2),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          backgroundColor: AppColors.lightBlue,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed:onPressed,
        child: Text(text),
      ),
    );
  }
}
