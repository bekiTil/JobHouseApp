part of 'changetheme_bloc.dart';

@immutable
abstract class ChangethemeEvent {}


class ChangethemeTODark extends ChangethemeEvent {}

class ChangethemeTOLight extends ChangethemeEvent {}