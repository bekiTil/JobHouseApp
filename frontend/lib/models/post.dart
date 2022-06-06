import 'package:frontend/data_Providers/post_data_provider.dart';
import 'package:frontend/utils/constants.dart';

class Post {
  String id;
  String poster_id;
  int number;
  String description;
  String category;
  String? image;
  String date;
  String posterName = " ";
  String posterProfilePicture =
      "$baseUrl/images/default_profile.png";

  Post(
      {required this.id,
      required this.poster_id,
      required this.number,
      required this.description,
      required this.category,
      required this.posterName,
      this.image,
      required this.date});

  factory Post.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['createdAt']);
    List months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return Post(
      id: json['_id'],
      poster_id: json['poster_id'],
      posterName: json['posterName'],
      number: json['number'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      date: months[date.month - 1] + ", " + date.day.toString(),
    );
  }
}
