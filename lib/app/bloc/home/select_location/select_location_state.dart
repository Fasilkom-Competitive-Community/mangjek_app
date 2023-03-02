part of 'select_location_cubit.dart';

@immutable
abstract class SelectLocationState extends Equatable {
  final bool isFocus;

  SelectLocationState(this.isFocus) {}
}

class SelectLocationFocused extends SelectLocationState {
  late final bool titikJemputFocus;
  late final bool titikTujuanFocus;

  SelectLocationFocused(this.titikJemputFocus, this.titikTujuanFocus)
      : super(true) {}

  @override
  List<Object?> get props => [isFocus, titikJemputFocus, titikTujuanFocus];
}

class SelectLocationNotFocused extends SelectLocationState {
  SelectLocationNotFocused() : super(false);

  @override
  List<Object?> get props => [isFocus];
}
