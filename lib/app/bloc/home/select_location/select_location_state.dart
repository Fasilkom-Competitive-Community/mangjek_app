part of 'select_location_cubit.dart';

@immutable
abstract class SelectLocationState extends Equatable {
  final bool isFocus;

  SelectLocationState(this.isFocus) {}
}

class SelectLocationFocused extends SelectLocationState {
  final FocusNode titikJemputFocusNode;
  late final bool titikJemputFocus;

  final FocusNode titikTujuanFocusNode;
  late final bool titikTujuanFocus;

  SelectLocationFocused(this.titikJemputFocusNode, this.titikTujuanFocusNode)
      : super(true) {
    this.titikJemputFocus = titikJemputFocusNode.hasFocus;
    this.titikTujuanFocus = titikTujuanFocusNode.hasFocus;
  }

  @override
  List<Object?> get props => [isFocus, titikJemputFocus, titikTujuanFocus];
}

class SelectLocationNotFocused extends SelectLocationState {
  SelectLocationNotFocused() : super(false);

  @override
  List<Object?> get props => [isFocus];
}
