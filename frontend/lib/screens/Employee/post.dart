class Post {
  String id;
  String poster_id;
  int number;
  String description;
  String category;
  String? image;

  // ---- Add the post owner's data when needed ---- //

  String? posterName;
  String? posterProfilePicture;

  // ------------------------------------------------ //

  Post({
    required this.poster_id,
    required this.id,
    required this.number,
    required this.description,
    required this.category,
    this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      number: json['number'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      poster_id: json['poster_id'],
    );
  }
}
