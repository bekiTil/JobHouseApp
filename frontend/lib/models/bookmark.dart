// ignore_for_file: non_constant_identifier_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Bookmark extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  Bookmark({
    required this.id,
    required this.user_id,
    required this.post_id,
    this.memo,
    this.createdAt,
  });

  final String id;
  final String user_id;
  final String post_id;
  final String? memo;
  final DateTime? createdAt;

  @override
  List<Object> get props => [id, user_id, post_id];

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
        id: json["_id"],
        user_id: json["user_id"],
        post_id: json["post_id"],
        memo: json["memo"],
        createdAt: DateTime.parse(json["createdAt"]));
  }
}
