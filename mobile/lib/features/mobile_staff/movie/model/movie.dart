class Movie {
  final String? id;
  final String title;
  final String? description;

  final String? imageUrl;
  final List? casts;
  final List? genera;

  // int get id => _id;

  Movie(
      {this.id,
      required this.title,
      this.description,
      this.imageUrl,
      this.casts,
      this.genera}) {
    // _id = id ?? Random.secure().nextInt(1000);
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      casts: json['casts'],
      genera: json['genera'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "description": description,
        "casts": casts,
        "genera": genera,
      };
}
