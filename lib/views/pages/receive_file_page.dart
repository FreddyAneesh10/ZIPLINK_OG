import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../services/socket_service.dart';
import '../../utils/file_utils.dart';
import '../../utils/utils.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_linear_percent_indicator_widget.dart';
import '../widgets/custom_text_field_widget.dart';

class ReceiveFilePage extends StatefulWidget {
  const ReceiveFilePage({super.key});

  @override
  State<ReceiveFilePage> createState() => _ReceiveFilePageState();
}

class _ReceiveFilePageState extends State<ReceiveFilePage> {
  final TextEditingController ipController = TextEditingController();
  final TextEditingController portController = TextEditingController();

  double progress = 0;
  String status = "Idle";
  bool isReceiving = false;
  final totalBytes = 1024 * 1024;

  final SocketService _socketService = SocketService();

  TextStyle? get bodySmall => Theme.of(
    context,
  ).textTheme.bodySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w300);

  Future<void> pickSavePathAndReceive() async {
    final savePath = await getSavePath(
      'received_file.txt',
    ); // automatic writable path
    final ip = ipController.text.trim();
    final port = int.tryParse(portController.text.trim()) ?? 8080;

    setState(() {
      isReceiving = true;
      status = "Connecting...";
      progress = 0;
    });

    try {
      // Use the SocketService's receiveFile method
      await _socketService.receiveFile(
        ip: ip,
        port: port,
        savePath: savePath,
        onProgress: (p) {
          setState(() {
            progress = p.clamp(0, 1);
            status = "Downloading... ${(progress * 100).toStringAsFixed(0)}%";
          });
        },
      );

      Utils.showSnackBar(context, "File received successfully!");
      setState(() {
        status = "Completed";
        isReceiving = false;
        progress = 1;
      });
    } catch (e) {
      setState(() {
        status = "Error";
        isReceiving = false;
      });
      Utils.showSnackBar(context, "Failed to receive file");
      print("Error receiving file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        leading: BackButton(
          color: AppColors.white,
          onPressed: () => context.go(AppRoutes.homePage),
        ),
        title: const Text("Receive File"),
        isCenter: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              Text("Enter Sender IP Address", style: bodySmall),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                controller: ipController,
                hint: 'Enter IP address',
                keyboardType: TextInputType.numberWithOptions(),
              ),

              const SizedBox(height: 20),

              Text("Enter Sender Port Number", style: bodySmall),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                controller: portController,
                hint: 'Enter port number',
                keyboardType: TextInputType.numberWithOptions(),
              ),

              const SizedBox(height: 30),

              Center(
                child: CustomElevatedButton(
                  text: isReceiving ? "Receiving..." : "Connect and receive",
                  onPressed: isReceiving ? null : pickSavePathAndReceive,
                ),
              ),

              const SizedBox(height: 40),

              Text('Progress', style: bodySmall),
              const SizedBox(height: 10),
              CustomLinearPercentIndicatorWidget(percent: progress),

              const SizedBox(height: 20),
              Text("Status: $status", style: bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
