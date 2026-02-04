import 'package:path_provider/path_provider.dart';

Future<String> getSavePath(String fileName) async {
  final dir = await getExternalStorageDirectory();
  return '${dir!.path}/$fileName';
}
