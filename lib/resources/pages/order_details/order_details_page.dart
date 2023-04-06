import 'package:flutter/material.dart';
import 'package:mangjek_app/resources/pages/order_details/widgets/build_bottom_sheet_widget.dart';
import 'package:mangjek_app/resources/pages/order_details/widgets/build_map_background_widget.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Widget backButtonTopBar() {
    return Container(
      color: Colors.white.withAlpha(0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            // background / map
            BuildMapBackground(),

            // Back button
            backButtonTopBar(),

            // bottom bar
            BuildBottomSheet(),
          ],
        ),
      ),
    );
  }
}
