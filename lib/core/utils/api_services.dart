import 'package:http/http.dart' as http;
import 'dart:io';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> postRequestImage({
    required String function,
    required File file,
  }) async {
    final url = '$baseUrl/$function';
    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      await http.MultipartFile.fromPath('file', file.path),
    );

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
