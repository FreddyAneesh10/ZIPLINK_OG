import 'package:flutter/material.dart';
import 'dart:io';
import '../../controllers/sender_controller.dart';
import '../../controllers/file_picker_controller.dart';
import '../../utils/network_helper.dart';
import '../../utils/utils.dart';
import '../../routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import '../../views/widgets/custom_app_bar_widget.dart';
import '../../views/widgets/custom_card_widget.dart';
import '../../views/widgets/custom_circular_percent_indicator.dart';
import '../../views/widgets/custom_elevated_button.dart';
import '../../views/widgets/custom_linear_percent_indicator_widget.dart';
import '../../models/file_model.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';

class SendFilePage extends StatefulWidget {
  const SendFilePage({super.key});

  @override
  State<SendFilePage> createState() => _SendFilePageState();
}

class _SendFilePageState extends State<SendFilePage> {
  String? ipAddress;
  final int port = 8080;

  final FilePickerController _filePickerController = FilePickerController();
  final SenderController _senderController = SenderController();

  FileModel? selectedFile;
  bool isSending = false;
  String status = "Idle";
  double progress = 0;

  TextStyle? get bodySmall => Theme.of(context).textTheme.bodySmall;

  @override
  void initState() {
    super.initState();
    loadIp();
  }

  Future<void> loadIp() async {
    final ip = await NetworkHelper.getLocalIp();
    setState(() {
      ipAddress = ip;
    });
  }

  Future<void> pickFile() async {
    final file = await _filePickerController.pickImage();
    if (file == null) return;
    setState(() {
      selectedFile = file;
    });
  }

  Future<void> startSending() async {
    if (selectedFile == null) {
      Utils.showSnackBar(context, "Please select a file");
      return;
    }

    setState(() {
      isSending = true;
      status = "Starting server...";
      progress = 0;
    });

    await _senderController.sendFile(
      selectedFile!.file,
      onProgress: (p) {
        setState(() {
          progress = p.clamp(0, 1);
          status = "Sending... ${(progress * 100).toStringAsFixed(0)}%";
        });
      },
    );

    setState(() {
      status = "Waiting for receiver...";
    });

    Utils.showSnackBar(context, "Server started. Receiver can connect now.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: BackButton(
          color: AppColors.white,
          onPressed: () => context.go(AppRoutes.homePage),
        ),
        title: const Text("Send File"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Center(
            child: CustomCardWidget(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Server Active", style: bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text("IP: ${ipAddress ?? 'Waiting...'}", style: bodySmall),
                        const Spacer(),
                        Image.asset(AppImages.hotspot, height: 30, color: AppColors.lightBlue),
                      ],
                    ),
                    Text("Port: $port", style: bodySmall),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          CustomCardWidget(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: selectedFile == null
                  ? Center(
                child: TextButton(
                  onPressed: pickFile,
                  child: Text("Select File", style: bodySmall?.copyWith(color: AppColors.lightBlue)),
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("File: ${selectedFile!.name}", style: bodySmall),
                  Text("Size: ${selectedFile!.formattedSize}", style: bodySmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          CustomElevatedButton(
            text: isSending ? "Sending..." : "Start Sending",
            onPressed: isSending ? null : startSending,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                // CustomCircularPercentIndicator(percent: progress),
                const SizedBox(width: 5),
                Text("Status: $status", style: bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
