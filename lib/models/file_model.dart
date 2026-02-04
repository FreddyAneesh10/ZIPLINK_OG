import 'dart:io';

class FileModel {
  final File file;
  final String name;
  final int size;

  FileModel({
    required this.file,
    required this.name,
    required this.size,
  });

  String get path => file.path;

  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(2)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
}
