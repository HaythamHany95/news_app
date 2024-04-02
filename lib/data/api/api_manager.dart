// ignore_for_file: use_rethrow_when_possible

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/data/api/api_constants.dart';
import 'package:news_app/data/models/articles_response.dart';
import 'package:news_app/data/models/sources_response.dart';

class ApiManager {
  static ApiManager? _instace;
  static ApiManager getInstace() {
    _instace ??= ApiManager._();
    return _instace!;
  }

  ApiManager._();

  /// Fetching News `Sourses`
  Future<SourcesResponse?> getNewsSourses(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.soursesEndpoint, {
      'apiKey': '7e883fc9bfd14d3ba75fca0738b2ca19',
      'category': categoryId,
    });
    try {
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      return SourcesResponse.fromJson(jsonData);
    } catch (e) {
      throw e;
    }
  }

  /// Fetch News `Articles` by News [Sourse Id]
  Future<ArticlesResponse?> getNewsArticles(String sourceID,
      {int? pageSize, int? page}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.articlesEndpoint, {
      'apiKey': '7e883fc9bfd14d3ba75fca0738b2ca19',
      'sources': sourceID,
      'pageSize': "10",
      'page': "$page"
    });

    try {
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      return ArticlesResponse.fromJson(jsonData);
    } catch (e) {
      throw e;
    }
  }

  /// Fetch News `Articles` with [query] of the `User` input in `SearchBar`
  static Future<ArticlesResponse?> getSearchedNewsArticles(String query) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.articlesEndpoint,
        {'apiKey': '7e883fc9bfd14d3ba75fca0738b2ca19', 'q': query});
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    return ArticlesResponse.fromJson(jsonData);
  }
  /**
   * https://newsapi.org/v2/top-headlines/sources?apiKey=
   * 1f947e49d6534e428bdda6cc3e84d7d6
   */
}
