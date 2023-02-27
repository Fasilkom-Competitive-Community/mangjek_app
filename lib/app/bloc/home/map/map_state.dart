part of 'map_cubit.dart';

@immutable
abstract class MapState extends Equatable {
  abstract final bool isReady;
}

class MapInitial extends MapState {
  final bool isReady = false;

  @override
  List<Object?> get props => [isReady];
}

class MapReady extends MapState {
  final bool isReady = true;

  final LatLng selectedLocation;
  final bool isSourceLocation;
  final bool isDestinationLocation;

  MapReady(this.selectedLocation, this.isSourceLocation, this.isDestinationLocation);

  @override
  List<Object?> get props => [isReady, selectedLocation.latitude, selectedLocation.longitude];
}
