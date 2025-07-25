import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../models/history_item.dart';

class ApiService {
  // IMPORTANT: This must match the address of your running Flask API.
  // FIX: Made _baseUrl public (baseUrl) so it can be accessed from other files.
  static const String baseUrl = "http://127.0.0.1:5000";

  /// Fetches the entire history of solved problems.
  Future<List<HistoryItem>> getHistory() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/history'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => HistoryItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load history from API.');
      }
    } catch (e) {
      print('Error in getHistory: $e');
      rethrow;
    }
  }

  /// Uploads an image file and returns the solution as a string.
  Future<String> uploadImage(XFile imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/upload'),
      );

      final fileBytes = await imageFile.readAsBytes();
      final httpImage = http.MultipartFile.fromBytes(
        'file', // This 'file' key must match the key in the Flask backend
        fileBytes,
        filename: imageFile.name,
        contentType: MediaType('image', imageFile.name.split('.').last),
      );

      request.files.add(httpImage);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['answer'];
      } else {
        final Map<String, dynamic> data = json.decode(response.body);
        throw Exception('Failed to upload image: ${data['error']}');
      }
    } catch (e) {
      print('Error in uploadImage: $e');
      rethrow;
    }
  }
}