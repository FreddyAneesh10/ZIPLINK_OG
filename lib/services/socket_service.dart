import 'dart:io';

class SocketService {
  ServerSocket? _server;

  Future<int> startServer(File file, {Function(double)? onProgress}) async {
    final port = 8080;
    final totalBytes = await file.length();

    _server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    print('Server started on port $port');

    _server!.listen((client) async {
      print('Client connected: ${client.remoteAddress.address}');

      try {
        int sentBytes = 0;

        // Send total file size as 12-byte string
        client.add(totalBytes.toString().padLeft(12, '0').codeUnits);

        final stream = file.openRead();
        await for (final chunk in stream) {
          client.add(chunk);
          sentBytes += chunk.length;
          if (onProgress != null) {
            onProgress(sentBytes / totalBytes);
          }
        }

        await client.flush();
        await client.close();
        print('File sent to client: ${client.remoteAddress.address}');
      } catch (e) {
        print('Error sending file: $e');
      }
    });

    return port;
  }

  /// Connect to sender and save file
  Future<void> receiveFile({
    required String ip,
    required int port,
    required String savePath,
    required Function(double) onProgress,
  }) async {
    final socket = await Socket.connect(ip, port);
    print('Connected to sender at $ip:$port');

    final file = File(savePath);
    final sink = file.openWrite();
    int receivedBytes = 0;

    int? totalBytes;
    List<int> buffer = [];

    await for (final data in socket) {
      // Append incoming data to buffer
      buffer.addAll(data);

      // Step 1: Read file size (first 12 bytes)
      if (totalBytes == null && buffer.length >= 12) {
        totalBytes = int.parse(String.fromCharCodes(buffer.take(12)));
        buffer = buffer.sublist(12); // remove size bytes from buffer
        print('Total file size: $totalBytes bytes');
      }

      // Step 2: Write remaining buffer to file
      if (totalBytes != null) {
        sink.add(buffer);
        receivedBytes += buffer.length;
        onProgress(receivedBytes / totalBytes);
        buffer = [];
      }
    }

    await sink.close();
    socket.destroy();
    print('File received and saved at $savePath');
  }

  /// Stop the server
  void stopServer() {
    _server?.close();
    print('Server stopped');
  }
}
