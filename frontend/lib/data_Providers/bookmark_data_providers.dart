import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/bookmark.dart';
import 'package:http/http.dart' as http;

class BookmarkDataProvider {
  final String _baseUrl = 'http://localhost:3000/bookmarks';
  final String _token = "token";

  Future<Bookmark> createBookmark(Bookmark bookmark) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-auth-token": _token,
      },
      body: jsonEncode(<String, dynamic>{
        "user_id": bookmark.user_id,
        "post_id": bookmark.post_id,
        "_id": bookmark.id,
        "memo": bookmark.memo,
        "create": bookmark.createdAt
      }),
    );

    if (response.statusCode == 200) {
      return Bookmark.fromJoson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load bookmark');
    }
  }

  Future<List<Bookmark>> getBookmarks() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-auth-token": _token,
      },
    );

    if (response.statusCode == 200) {
      final bookmarks = jsonDecode(response.body) as List;
      return bookmarks.map((bookmark) => Bookmark.fromJoson(bookmark)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Bookmark> updateBookmarks(Bookmark bookmark) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${bookmark.id}'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-auth-token": _token,
      },
      body: jsonEncode(<String, dynamic>{
        "user_id": bookmark.user_id,
        "post_id": bookmark.post_id,
        "_id": bookmark.id,
        "memo": bookmark.memo,
        "create": bookmark.createdAt
      }),
    );

    if (response.statusCode == 200) {
      return Bookmark.fromJoson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update bookmark');
    }
  }

  Future<void> deleteBookmark(int id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-auth-token": _token,
      },
    );
    if (response.statusCode != 200) {
      throw Exception("unable to delete");
    }
  }
}
