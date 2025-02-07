class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;
  final String publishedTime;
  final String author;
  final String sourceName;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.content,
    required this.urlToImage,
    required this.publishedTime,
    required this.author,
    required this.sourceName
  });

  factory Article.fromJson(Map<String, dynamic> json) {

    String formatContent(String? rawContent) {
      if (rawContent == null || rawContent.isEmpty) return '';
      
      String formatted = rawContent.replaceAll(RegExp(r'\[\+\d+ chars\]'), 'more');
      
      formatted = formatted
          .replaceAll('&amp;', '&')
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>')
          .replaceAll('&quot;', '"')
          .replaceAll('&apos;', "'");
      
      if (formatted.endsWith('...')) {
        formatted = formatted.substring(0, formatted.length - 3);
      }
      
      return formatted;
    }

    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      content: formatContent(json['content']),
      publishedTime: json['publishedAt'] ?? DateTime.now.toString(),
      author: json['author'] ?? 'Unknown Author',
      sourceName: json['source']['name'] ?? 'Unknown Source',
    );
  }
}