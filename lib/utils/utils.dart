import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white)),
          backgroundColor: backgroundColor,
          duration: duration,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

Future<dynamic> push(BuildContext context, Widget route) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => route),
  );
}

void pop(BuildContext context) {
  return Navigator.pop(context);
}
