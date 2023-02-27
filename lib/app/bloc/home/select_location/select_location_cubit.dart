import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'select_location_state.dart';

class SelectLocationCubit extends Cubit<SelectLocationState> {
  SelectLocationCubit() : super(SelectLocationNotFocused());

  void focusSelectLocation(
      FocusNode titikJemputFocus, FocusNode titikTujuanFocus) {
    if (titikJemputFocus.hasFocus || titikTujuanFocus.hasFocus) {
      emit(SelectLocationFocused(titikJemputFocus, titikTujuanFocus));
    } else {
      emit(SelectLocationNotFocused());
    }
  }
}
