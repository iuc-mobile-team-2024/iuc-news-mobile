import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/scraping_item.dart';

class ScrapingService {
  static const String baseUrl = 'http://127.0.0.1:5000';

  Future<String> createScrapingRequest(ScrapingItem item) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/monitor'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(item.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['id'];
      } else {
        throw Exception('Failed to create scraping request: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> getScrapingResults(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_request/$id'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get scraping results: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}