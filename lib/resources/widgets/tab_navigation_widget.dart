import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/tab_navigation/tab_navigation_cubit.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:nylo_framework/nylo_framework.dart';

class TabNavigation extends StatefulWidget {
  TabNavigation({Key? key}) : super(key: key);

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends NyState<TabNavigation> {
  @override
  init() async {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late TabNavigationCubit _tabNavigationCubit;

  @override
  Widget build(BuildContext context) {
    _tabNavigationCubit = context.read<TabNavigationCubit>();

    return BlocBuilder<TabNavigationCubit, TabNavigationState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            iconSize: 28,
            backgroundColor: 'EBEFED'.toColor(),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(getImageAsset('home.png')),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(getImageAsset('book.png')),
                ),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(getImageAsset('menu.png')),
                ),
                label: 'Menu',
              ),
            ],
            currentIndex: state.activeIndex,
            selectedItemColor: 'F3C703'.toColor(),
            selectedIconTheme: IconThemeData(
              color: 'F3C703'.toColor(),
            ),
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }

  void _onItemTapped(int newIndex) {
    _tabNavigationCubit.changeActiveTabIndex(newIndex);
  }
}
