// ignore_for_file: non_constant_identifier_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/models.dart';

@immutable
class Bookmark extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  Bookmark({
    this.id,
    required this.user_id,
    required this.post_id,
    required this.post,
    this.memo,
    this.createdAt,
  });

  late String? id;
  final String user_id;
  final String post_id;
  late Post post;
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
        post: json["post"],
        createdAt: DateTime.parse(json["createdAt"]));
  }
}
