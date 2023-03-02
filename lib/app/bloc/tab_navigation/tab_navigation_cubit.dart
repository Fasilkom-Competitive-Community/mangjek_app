import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_navigation_state.dart';

class TabNavigationCubit extends Cubit<TabNavigationState> {
  TabNavigationCubit() : super(TabNavigationState(0));

  void changeActiveTabIndex(int index) {
    emit(TabNavigationState(index));
  }
}
