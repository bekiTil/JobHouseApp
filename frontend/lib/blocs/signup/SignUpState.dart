import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String exception;

  const SignUpFailure(this.exception);
  
}
