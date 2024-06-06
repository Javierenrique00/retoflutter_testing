class NewsEntity {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String sourceName;

  NewsEntity({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.sourceName,
  });

  @override
  bool operator ==(Object other){
    return other is NewsEntity &&
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
