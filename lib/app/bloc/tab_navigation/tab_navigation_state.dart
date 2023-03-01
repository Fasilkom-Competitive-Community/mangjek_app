part of 'tab_navigation_cubit.dart';

class TabNavigationState extends Equatable {
  final int activeIndex;

  const TabNavigationState(this.activeIndex);

  @override
  List<Object> get props => [activeIndex];
}
