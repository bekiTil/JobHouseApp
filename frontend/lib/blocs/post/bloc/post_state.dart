part of 'post_bloc.dart';

@immutable
abstract class PostState extends Equatable {}

class PostInitial extends PostState {
  PostInitial() : super();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostOperationLoading extends PostState {
  PostOperationLoading() : super();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostOperationSuccess extends PostState {
  PostOperationSuccess() : super();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostOperationFailed extends PostState {
  final String exception;

  PostOperationFailed(this.exception) : super();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PostEditingOperationStarted extends PostState {
  final Post post;

  PostEditingOperationStarted(this.post);

  @override
  // TODO: implement props
  List<Object?> get props => [throw UnimplementedError()];
}
