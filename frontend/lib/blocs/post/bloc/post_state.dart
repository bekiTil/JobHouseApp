part of 'post_bloc.dart';

@immutable
abstract class PostState {
  final Post post;

  PostState(this.post);
  
}

class PostInitial extends PostState {
  PostInitial(Post post) :super(post);
}

class PostCreating extends PostState {
  PostCreating(Post post) : super(post);
}

class PostCreated extends PostState {
  PostCreated(Post post) : super(post);
}

class PostCreationFailed extends PostState {
  final String exception;

  PostCreationFailed(this.exception, Post post) : super(post);

  
}

