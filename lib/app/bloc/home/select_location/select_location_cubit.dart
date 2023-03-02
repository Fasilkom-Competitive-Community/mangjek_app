import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'select_location_state.dart';

class SelectLocationCubit extends Cubit<SelectLocationState> {
  SelectLocationCubit() : super(SelectLocationNotFocused());

  FocusNode? focusNodeTitikJemput = FocusNode(debugLabel: "focus_titik_jemput");
  FocusNode? focusNodeLokasiTujuan =
      FocusNode(debugLabel: "focus_titik_tujuan");

  // 0 => titik jemput focused
  // 1 => titik tujuan focused
  int lastIndexFocused = 0;

  void setLastIndexFocused(int newIndex) {
    lastIndexFocused = newIndex;
  }

  void reinitFocusNodeIfNeeded() {
    if (focusNodeTitikJemput == null) {
      focusNodeTitikJemput = FocusNode(debugLabel: "focus_titik_jemput");
    }
    if (focusNodeLokasiTujuan == null) {
      focusNodeLokasiTujuan = FocusNode(debugLabel: "focus_titik_tujuan");
    }
  }

  void focusSelectLocation() {
    if (focusNodeTitikJemput!.hasFocus || focusNodeLokasiTujuan!.hasFocus) {
      emit(
        SelectLocationFocused(
            focusNodeTitikJemput!.hasFocus, focusNodeLokasiTujuan!.hasFocus),
      );
    } else {
      emit(SelectLocationNotFocused());
    }
  }
}
