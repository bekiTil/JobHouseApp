import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/data_Providers/local/db_provider.dart';
import 'package:frontend/data_Providers/local/mock_model/book_mark.dart';
import 'package:frontend/data_Providers/local/mock_model/merge.dart';
import 'package:frontend/data_Providers/local/mock_model/post_.dart';
import 'package:frontend/models/bookmark.dart';
import 'package:frontend/utils/exception.dart';
import 'package:http/http.dart' as http;
import '../repository/repository.dart';

class BookmarkDataProvider {
  final String _baseUrl = 'http://10.0.2.2:3000/api/bookmarks';

  Future<Bookmark> createBookmark(Bookmark bookmark) async {
    StorageService storage = StorageService();
    final String? token = await storage.getToken();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        "x-auth-token": token!,
        "Content-Type": "application/json",
      },
      body: json.encode({
        "user_id": bookmark.user_id,
        "post_id": bookmark.post_id,
        "memo": bookmark.memo,
      }),
    );

    if (response.statusCode == 200) {
      // final bookValue = MockBookmark.fromApi(jsonDecode(response.body));
      // final createdBook = await DBProvider.db.createBookmark(bookValue);

      return Bookmark.fromJson(jsonDecode(response.body));
    } else {
      throw AuthException('Failed to load bookmark');
    }
  }

  Future<List<Bookmark>> getBookmarks() async {
    StorageService storage = StorageService();
    final String? token = await storage.getToken();
    // final fetchbookmarks = await DBProvider.db.mockbookmarks();
    // if (fetchbookmarks != null) {
    //   return fetchbookmarks.map((mockbook) => mergeBookmark(mockbook)).toList();
    // }
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        "x-auth-token": token!,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*",
        "Access-Control-Allow-Credentials": "true"
      },
    );

    if (response.statusCode == 200) {
      final bookmarks = jsonDecode(response.body) as List;
      return bookmarks.map((bookmark) => Bookmark.fromJson(bookmark)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Bookmark> updateBookmarks(Bookmark bookmark) async {
    StorageService storage = StorageService();
    final String? token = await storage.getToken();

    final response = await http.put(
      Uri.parse('$_baseUrl/${bookmark.id}'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "x-auth-token": token!,
      },
      body: jsonEncode(<String, dynamic>{
        "user_id": bookmark.user_id,
        "post_id": bookmark.post_id,
        "memo": bookmark.memo,
      }),
    );

    if (response.statusCode == 200) {
  // final bookValue = MockBookmark.fromApi(jsonDecode(response.body));
  // await DBProvider.db.UpdateBookmark(bookValue);
      return Bookmark.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update bookmark');
    }
  }

  Future<void> deleteBookmark(String id) async {
    StorageService storage = StorageService();
    final String? token = await storage.getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        "x-auth-token": token!,
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*",
        "Access-Control-Allow-Credentials": "true"
      },
    );
    if (response.statusCode != 200) {
      throw Exception("unable to delete");
    }
  }
}
