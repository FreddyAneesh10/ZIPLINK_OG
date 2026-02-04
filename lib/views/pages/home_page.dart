import 'package:file_sharing_app/constants/app_colors.dart';
import 'package:file_sharing_app/constants/app_images.dart';
import 'package:file_sharing_app/routes/app_routes.dart';
import 'package:file_sharing_app/utils/utils.dart';
import 'package:file_sharing_app/views/widgets/custom_container_widget.dart';
import 'package:file_sharing_app/views/widgets/custom_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/hotspot_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showHotspotDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Enable Wi-Fi / Hotspot"),
        content: const Text(
          "Please turn on Wi-Fi or Wi-Fi Hotspot to start sharing files.",
        ),
        actions: [
          CustomTextButtonWidget(
            onPressed: () => Navigator.pop(context),
            text: "Cancel",
          ),
          CustomTextButtonWidget(
            onPressed: () async {
              Navigator.pop(context);
              await HotspotHelper.openHotspotSettings();
              Future.delayed(const Duration(milliseconds: 300), () {
                context.go(AppRoutes.sendFilePage);
              });
            },
            text: "Go to Hotspot settings",
            color: AppColors.lightBlue,
          ),
        ],
      ),
    );
  }
  void _showWifiDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Enable Wi-Fi"),
        content: const Text(
          "Please turn on Wi-Fi to start receiving files.",
        ),
        actions: [
          CustomTextButtonWidget(
            onPressed: () => Navigator.pop(context),
            text: "Cancel",
          ),
          CustomTextButtonWidget(
            onPressed: () async {
              Navigator.pop(context);
              await HotspotHelper.openWifiSettings();
              Future.delayed(const Duration(milliseconds: 300), () {
                context.go(AppRoutes.receiveFilePage);
              });
            },
            text: "Go to wifi settings",
            color: AppColors.lightBlue,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          Text('Wi-Fi Sharing', style: Theme.of(context).textTheme.bodyLarge),
          Image.asset(
            AppImages.hotspot,
            color: Colors.grey,
            height: screenHeight(context, dividedBy: 3.5),
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomContainerWidget(
                img: AppImages.upArrow,
                text: 'Send',
                onTap: () {
                  _showHotspotDialog(context);
                },
              ),
              CustomContainerWidget(
                img: AppImages.downArrow,
                text: 'Receive',
                onTap: () {
                  _showWifiDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
