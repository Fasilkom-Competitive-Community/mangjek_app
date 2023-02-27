import 'package:flutter/material.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:nylo_framework/nylo_framework.dart';

class TabNavigation extends StatefulWidget {
  TabNavigation({Key? key}) : super(key: key);

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends NyState<TabNavigation>
    with TickerProviderStateMixin {
  late TabController controller;

  @override
  init() async {
    super.init();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: '#EBEFED'.toColor(),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0))),
        child: TabBar(
          controller: controller,
          tabs: [
            Tab(
              icon: Image.asset(
                getImageAsset("home.png"),
                color: '#F3C703'.toColor(),
              ),
              child: Text(
                "Beranda",
                style: TextStyle(color: '#1E1E1E'.toColor()),
              ),
            ),
            Tab(
              icon: Image.asset(
                getImageAsset("book.png"),
              ),
              child: Text(
                "Riwayat",
                style: TextStyle(color: '#1E1E1E'.toColor()),
              ),
            ),
            Tab(
              icon: Image.asset(getImageAsset("menu.png")),
              child: Text(
                "Menu",
                style: TextStyle(color: '#1E1E1E'.toColor()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
