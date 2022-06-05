// ignore_for_file: non_constant_identifier_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/models.dart';

@immutable
class Bookmark extends Equatable {
  const Bookmark({
    this.id,
    required this.user_id,
    required this.post_id,
    required this.post,
    this.memo,
    this.createdAt,
  });

  final String? id;
  final String user_id;
  final String post_id;
  final Post post;
  final String? memo;
  final DateTime? createdAt;

  @override
  List<Object> get props => [];

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json["_id"],
      user_id: json["user_id"],
      post_id: json["post_id"],
      memo: json["memo"],
      post: Post.fromJson(
        json["post"]!,
      ),
    );
  }
}
