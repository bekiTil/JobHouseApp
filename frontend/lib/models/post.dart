class Post {
  String id;
  int number;
  String description;
  String category;
  int? image;

  Post(
      {required this.id,
      required this.number,
      required this.description,
      required this.category,
      this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['poster_id'],
        number: json['number'],
        description: json['description'],
        category: json['category'],
        image: json['image']);
  }
}
