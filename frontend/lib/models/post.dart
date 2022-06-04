import 'package:frontend/data_Providers/post_data_provider.dart';

class Post {
  String id;
  String poster_id;
  int number;
  String description;
  String category;
  String? image;

  String? posterName;
  String? posterProfilePicture;

  void setPosterData() async {
    var url = "http://10.0.2.2:3000/";
    final postDataProvider = PostDataProvider();
    final userData = await postDataProvider.findOwnerInfo(poster_id);

    posterName = userData['posterName'];
    posterProfilePicture = url + userData['posterProfilePicture']!;

    if (image != null && image!.isNotEmpty) {
      image = url + image!;
    }
  }

  Post({
    required this.id,
    required this.poster_id,
    required this.number,
    required this.description,
    required this.category,
    this.image,
  }) {
    setPosterData();
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['_id'],
        poster_id: json['poster_id'],
        number: json['number'],
        description: json['description'],
        category: json['category'],
        image: json['image']);
  }
}
