import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../constants/app_colors.dart';

class CustomCircularPercentIndicator extends StatelessWidget {
  final double percent;

  const CustomCircularPercentIndicator({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 35.0,
      lineWidth: 4.0,
      percent: percent,
      center: Text(
        "90%",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
      progressColor: AppColors.lightBlue,
    );
  }
}
