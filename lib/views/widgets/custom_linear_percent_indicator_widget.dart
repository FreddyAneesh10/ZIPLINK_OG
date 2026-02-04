import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../constants/app_colors.dart';

class CustomLinearPercentIndicatorWidget extends StatelessWidget {
  final double? width;
  final double percent; // value between 0.0 and 1.0

  const CustomLinearPercentIndicatorWidget({
    super.key,
    this.width,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final double safeWidth = (width != null && width! > 0)
        ? width!
        : MediaQuery.of(context).size.width - 40;

    return LinearPercentIndicator(
      width: safeWidth,
      animation: true,
      lineHeight: 20.0,
      animationDuration: 250,
      percent: percent.clamp(0, 1),
      center: Text(
        "${(percent * 100).toStringAsFixed(0)}%",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w300,
          color: AppColors.white,
        ),
      ),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: AppColors.lightBlue,
      backgroundColor: Colors.grey.shade300,
    );
  }
}
