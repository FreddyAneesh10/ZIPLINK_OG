import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../models/file_model.dart';

class FilePickerController {
  Future<FileModel?> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image, // images only for now
      );

      if (result == null || result.files.single.path == null) {
        return null;
      }

      final file = File(result.files.single.path!);

      return FileModel(
        file: file,
        name: result.files.single.name,
        size: file.lengthSync(),
      );
    } catch (e) {
      return null;
    }
  }
}
