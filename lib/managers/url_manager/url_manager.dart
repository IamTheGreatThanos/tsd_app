class UrlManager {
  final String baseUrl;

  String getImageUrl(String imageName) {
    return baseUrl + 'images/' + imageName;
  }

  UrlManager(this.baseUrl);
}
