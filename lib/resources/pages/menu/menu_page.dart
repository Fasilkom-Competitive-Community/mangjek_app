import 'package:flutter/material.dart';
import 'package:mangjek_app/resources/pages/menu/constant.dart';
import 'package:mangjek_app/resources/pages/menu/widgets/info_lainnya_widget.dart';
import 'package:mangjek_app/resources/pages/menu/widgets/profile_tab_widget.dart';
import 'package:mangjek_app/resources/widgets/page_top_bar.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:sizer/sizer.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultHorizontalPadding,
            ).copyWith(
              top: 20,
            ),
            child: PageTopBar(withBackIcon: false, pageName: "Menu"),
          ),
          SizedBox(
            height: 3.2.h,
          ),
          InkWell(
            onTap: () {
              routeTo(ROUTE_PROFILE_PAGE);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultHorizontalPadding,
                vertical: 10,
              ),
              child: ProfileTab(),
            ),
          ),
          SizedBox(
            height: 3.2.h,
          ),
          Expanded(
            child: InfoLainnya(),
          ),
        ],
      ),
    );
  }
}
