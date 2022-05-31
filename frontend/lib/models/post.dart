class Post {
  int id;
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
        id: json['_id'],
        number: json['number'],
        description: json['description'],
        category: json['category'],
        image: json['image']);
  }
}