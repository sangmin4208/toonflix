import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";

  final String today = "today";

  Future<List<Webtoon>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List<dynamic>;
      return data.map((e) => Webtoon.fromJson(e)).toList();
    }
    throw Exception("Failed to load today's toons");
  }
}
