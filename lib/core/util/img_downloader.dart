// image_service.dart
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String> downloadAndSaveImage(String imageUrl) async {
  final directory = await getApplicationDocumentsDirectory();
  final fileName = imageUrl.split('/').last; // Get the file name from the URL
  final filePath = '${directory.path}/$fileName';

  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  } else {
    throw Exception('Failed to download image');
  }
}
