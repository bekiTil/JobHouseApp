import 'dart:convert';
import 'package:frontend/repository/repository.dart';
import 'package:frontend/utils/exception.dart';
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
    });
  }

  Future<Post> create(Map post) async {
    StorageService storage = StorageService();
    final String? token = await storage.getToken();
    final http.Response response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-auth-token": token!,
      },
      body: json.encode(post),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }

    throw AuthException(response.body);
  }

  Future<Post> fetchById(String id) async {
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
      var posts = jsonDecode(response.body) as List;
      posts = posts.map((post) => Post.fromJson(post)).toList();
      await Future.delayed(Duration(seconds: 1));
      return posts as List<Post>;
    } else {
      throw Exception("Could not fetch posts");
    }
  }

  Future<List<Post>> fetchAllByUserId() async {
    StorageService storage = StorageService();
    final String? posterId = await storage.getId();
    final response = await http.get(Uri.parse("$_baseUrl/user/$posterId"));

    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      return posts.map((c) => Post.fromJson(c)).toList();
    } else {
      throw AuthException("OOPs... You don't have any posts");
    }
  }

  Future<Post> update(String id, Post post) async {
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

  Future<void> delete(String id) async {
    StorageService storage = StorageService();
    final String? token = await storage.getToken();
    final response = await http
        .delete(Uri.parse("$_baseUrl/$id"), headers: {"x-auth-token": token!});
    if (response.statusCode != 204) {
      throw AuthException(response.body);
    }
  }

  Future<Map<String, String>> findOwnerInfo(String id) async {
    var url = Uri.parse('http://10.0.2.2:3000/api/users/$id');
    var defaultProfilePicture = "images/default_profile.png";

    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final user = jsonDecode(response.body);
      return {
        'posterName': user['fullName'],
        'posterProfilePicture': user['image'] ?? defaultProfilePicture
      };
    }
    throw Exception('Error');
  }
}
