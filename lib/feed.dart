class Feed {
  final String name;
  final String email;

  Feed(this.name, this.email);

  Feed.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];
}

class Image {
  final String title;
  final ImageInfo thumbnail;
  final ImageInfo image;

  Image(this.title, this.thumbnail, this.image);

  Image.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumbnail = json['thumbnail'],
        image = json['image'];
}

class ImageInfo {
  final String source;
  final int width;
  final int height;

  ImageInfo(this.source, this.width, this.height);

  ImageInfo.fromJson(Map<String, dynamic> json)
      : source = json['source'],
        width = json['width'],
        height = json['height'];
}