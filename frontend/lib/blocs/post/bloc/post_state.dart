part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {
  PostInitial() : super();
}

class PostOperationLoading extends PostState {
  PostOperationLoading() : super();
}

class PostOperationSuccess extends PostState {
  PostOperationSuccess() : super();
}

class PostOperationFailed extends PostState {
  final String exception;

  PostOperationFailed(this.exception) : super();
}

class PostEditingOperationStarted extends PostState {
  final Post post;

  PostEditingOperationStarted(this.post);
}

class PostEditingOperationSuccess extends PostState{}
