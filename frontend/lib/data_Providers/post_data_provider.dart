import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostDataProvider {
  static const String _baseUrl = "http://10.0.2.2:3000/api/posts";
  static const String _token = "TODO:";

  String jsonify(Post post) {
    return jsonEncode({
      "description": post.description,
      "number": post.number,
      "category": post.category,
      "image": post.image,
    });
  }

  Future<Post> create(Post post) async {
    final http.Response response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-auth-token": _token,
      },
      body: jsonify(post),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }

    throw Exception("An Error happened while creating post");
  }

  Future<Post> fetchById(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Couldn't get the post.");
    }
  }

  Future<List<Post>> fetchAll() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      return posts.map((c) => Post.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch posts");
    }
  }

  Future<Post> update(int id, Post post) async {
    final response = await http.put(
      Uri.parse("$_baseUrl/$id"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-auth-token": _token,
      },
      body: jsonify(post),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the post");
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$id"));
    if (response.statusCode != 204) {
      throw Exception("Failed to delete the post");
    }
  }
}
