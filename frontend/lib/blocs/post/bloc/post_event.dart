part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class CreatePost extends PostEvent {}

class DeletePost extends PostEvent {}

class EditPost extends PostEvent {}




