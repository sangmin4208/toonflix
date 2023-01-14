import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_tail_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static const String today = "today";

  static Future<List<Webtoon>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List<dynamic>;
      return data.map((e) => Webtoon.fromJson(e)).toList();
    }
    throw Exception("Failed to load today's toons");
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      return WebtoonDetailModel.fromJson(data);
    }
    throw Exception("Failed to load toon");
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final url = Uri.parse('$baseUrl/$id/episodes');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final episodesData = jsonDecode(resp.body) as List<dynamic>;
      return episodesData.map((e) => WebtoonEpisodeModel.fromJson(e)).toList();
    }
    throw Exception("Failed to load latest episode");
  }
}
