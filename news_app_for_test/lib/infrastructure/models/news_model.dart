
class NewsModel {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String sourceName;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.sourceName,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      sourceName: json['source']['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
    };
  }

    @override
  bool operator ==(Object other){
    return other is NewsModel &&
      other.runtimeType == runtimeType &&
      other.title == title &&
      other.description == description &&
      other.url == url &&
      other.urlToImage == urlToImage &&
      other.sourceName == sourceName;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      title,
      description,
      url,
      urlToImage,
      sourceName,);
  }

}
