class Post {
  int number;
  String description;
  String category;
  int? image;

  Post({
      required this.number,
      required this.description,
      required this.category,
      this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        number: json['number'],
        description: json['description'],
        category: json['category'],
        image: json['image']);
  }
}
