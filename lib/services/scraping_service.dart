import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/scraping_item.dart';

class ScrapingService {
  static const String baseUrl = 'http://127.0.0.1:5000';

  // Create a scraping request (POST)
  Future<String> createScrapingRequest(ScrapingItem item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/scrape_request'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': item.title,
        'url': item.url,
        'method': item.method,
        'selector': item.selector,
        'interval': item.interval ?? 3600,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return data['id'];
    } else {
      throw Exception('Failed to create scraping request: ${response.body}');
    }
  }

  // Get all scraping requests (GET)
  Future<List<ScrapingItem>> getScrapingRequests() async {
    final response = await http.get(Uri.parse('$baseUrl/api/monitors'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => ScrapingItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get scraping requests: ${response.body}');
    }
  }

  // Get scraping result by ID (GET)
  Future<ScrapingItem> getScrapingResults(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/monitors?id=$id'));

    if (response.statusCode == 200) {
      return ScrapingItem.fromJson(json.decode(response.body)[0]); // Assuming the response is an array
    } else {
      throw Exception('Failed to get scraping results: ${response.body}');
    }
  }
}
