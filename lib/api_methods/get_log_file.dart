import 'dart:io';

import 'package:auditplus_fx/api_methods/contants.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadLogFile() async {
  final dio = Dio();

  final dir = await getExternalStorageDirectory();
  final filePath = '${dir!.path}/log.txt'; // ✅ use String

  try {
    final response = await dio.get("$url/get-log", options: Options(responseType: ResponseType.bytes));

    final file = File(filePath);

    await file.writeAsBytes(response.data);

    print("Downloaded to: $filePath");
  } catch (e) {
    print("Download failed: $e");
  }
}
