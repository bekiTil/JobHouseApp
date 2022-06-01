part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostCreating extends PostState {}

class PostUpdating extends PostState {}

class PostFailed extends PostState {}
