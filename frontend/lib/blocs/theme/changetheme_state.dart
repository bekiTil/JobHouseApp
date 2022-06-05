part of 'changetheme_bloc.dart';

@immutable
abstract class ChangethemeState {}

class ChangethemeInitial extends ChangethemeState {}


class DarkTheme extends ChangethemeState {}
class LightTheme extends ChangethemeState {}