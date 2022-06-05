import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../darkTheme.dart';

part 'changetheme_event.dart';
part 'changetheme_state.dart';

class ChangethemeBloc extends Bloc<ChangethemeEvent, ChangethemeState> {
  ChangethemeBloc() : super(ChangethemeInitial()) {
    on<ChangethemeTODark>((event, emit) {
      
      emit (DarkTheme());

    });

    on<ChangethemeTOLight>((event, emit) {
      emit (LightTheme());
    });
  }
}
