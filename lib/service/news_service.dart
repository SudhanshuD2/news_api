import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_api/model/article.dart';

class NewsService {
  static const String apiKey = 'b337d61816fa4f6aa875c4498e53adbb';
  static const String baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<Article>> getNews() async {
    final response = await http.get(
      Uri.parse('$baseUrl?country=us&apiKey=$apiKey'),
    );
    
    if (response.statusCode == 200) {

      final json = jsonDecode(response.body);
      final articles = json['articles'] as List;
      return articles.map((article) => Article.fromJson(article)).toList();
    
    } else {
    
      throw Exception('Failed to load news');
    
    }
  }
}