import 'dart:io';
import '../services/socket_service.dart';

class SenderController {
  final SocketService _service = SocketService();

  Future<int> sendFile(
      File file, {
        void Function(double)? onProgress,
      }) async {
    return await _service.startServer(file, onProgress: onProgress);
  }

  void stop() {
    _service.stopServer();
  }
}
