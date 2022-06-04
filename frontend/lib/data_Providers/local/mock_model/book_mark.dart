import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:frontend/data_Providers/local/mock_model/post_.dart';

import '../../../models/bookmark.dart';
import '../../../models/post.dart';

@immutable
class MockBookmark extends Equatable {
  late String? id;
  final String? user_id;
  final String? post_id;
  final String? memo;
  final int number;
  final  String description;
  final  String category;

  MockBookmark({
    this.id,

    required this.number,
    required this.description,
    required this.category,
    required this.user_id,
    required this.post_id,
    required this.memo,
  });
  @override
  List<Object?> get props => [];

  factory MockBookmark.fromJson(Map<String, dynamic> json) {
    return MockBookmark(
      id: json["_id"],
      post_id:json["post_id"],
      user_id:json["user_id"],
      memo:json["memo"],
      number: json['number'],
      description: json['description'],
      category: json['category']);
  
  }
  factory MockBookmark.fromApi(Map<String, dynamic> json) {
    return MockBookmark(
      id: json["_id"],
      post_id:json["post_id"],
      user_id:json["user_id"],
      memo:json["memo"],
      number: json['post']['number'],
      description: json['post']['description'],
      category: json['post']['category']);
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "post_id":post_id,
        "user_id": user_id,
        "memo":memo ,
        "number": number,
        "description": description,
        "category": category,
        
      };
 
}
