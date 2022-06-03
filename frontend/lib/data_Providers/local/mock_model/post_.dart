class MockPost {
  String id;
  int number;
  String description;
  String category;

  MockPost({
    required this.id,
    required this.number,
    required this.description,
    required this.category,
  });

  factory MockPost.fromJson(Map<String, dynamic> json) {
    return MockPost(
        id: json['_id'],
        number: json['number'],
        description: json['description'],
        category: json['category']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "description": description,
        "category": category,
      };
  factory MockPost.fromApi(Map<String, dynamic> json) {
    return MockPost(
        id: json['post']['_id'],
        number: json['post']['number'],
        description: json['post']['description'],
        category: json['post']['category']);
  }
}
