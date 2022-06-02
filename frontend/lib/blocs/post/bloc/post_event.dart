part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class PostCreate extends PostEvent {
  final String description;
  final int number;
  final String category;

  PostCreate(this.description, this.number, this.category);
}

class DeletePost extends PostEvent {
  final String id;

  DeletePost(this.id);
}

class EditPost extends PostEvent {}
