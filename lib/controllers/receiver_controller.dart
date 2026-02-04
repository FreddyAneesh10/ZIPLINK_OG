import '../services/socket_service.dart';

class ReceiverController {
  final SocketService _service = SocketService();

  Future<void> receive({
    required String ip,
    required int port,
    required String path,
    required int totalBytes, // <- must know the file size
    required Function(double) onProgress,
  }) async {
    await _service.receiveFile(
      ip: ip,
      port: port,
      savePath: path,
      onProgress: onProgress,
    );
  }
}
