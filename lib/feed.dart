class Feed {
  final Image image;

  const Feed({
    required this.image
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(image: json['image']);
  }
}

class Image {
  final String title;
  final ImageInfo thumbnail;
  final ImageInfo image;

  const Image({
    required this.title,
    required this.thumbnail,
    required this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      title: json['title'],
      thumbnail: json['thumbnail'],
      image: json['image'],
    );
  }
}

class ImageInfo {

  final String source;
  final int width;
  final int height;

  const ImageInfo({
    required this.source,
    required this.width,
    required this.height,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      source: json['source'],
      width: json['width'],
      height: json['height'],
    );
  }
}