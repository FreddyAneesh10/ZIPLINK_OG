import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget? child;

  const CustomCardWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(context, dividedBy: 1.2),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}
