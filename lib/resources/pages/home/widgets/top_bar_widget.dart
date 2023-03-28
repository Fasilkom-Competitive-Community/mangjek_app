import 'package:flutter/material.dart';
import 'package:mangjek_app/app/constants/choose_location.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';

class TopBarHomeWidget extends StatefulWidget {
  const TopBarHomeWidget({super.key});

  @override
  State<TopBarHomeWidget> createState() => _TopBarHomeWidgetState();
}

class _TopBarHomeWidgetState extends State<TopBarHomeWidget> {
  Widget buildTopBar() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Color(0xFFF3C703),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  _buildTopProfileBar(),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 70.0,
          child: Container(
            child: InputLocationWidget(
              isEnabled: false,
              onTapJemput: onTapInputLocation(ChooseLocationType.TitikJemput),
              onTapTujuan: onTapInputLocation(ChooseLocationType.TitikTujuan),
            ),
          ),
        ),
      ],
    );
  }

  void Function() onTapInputLocation(ChooseLocationType locationType) {
    return () {
      routeTo(
        ROUTE_ORDERS_CHOOSE_LOCATION,
        pageTransition: PageTransitionType.fade,
        data: locationType,
      );
    };
  }

  Widget _buildTopProfileBar() {
    return Wrap(
      children: [
        Container(
          // height: 100.0,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF3C703),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(),
                child: Row(
                  children: [
                    Image.asset(getImageAsset("profile.png")),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Gandi Subara",
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 2.0)),
                        Text(
                          "Fasilkom",
                          style: TextStyle(color: Colors.black, fontSize: 10.0),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Image.asset(
                      getImageAsset("logo-2.png"),
                      scale: 3.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            buildTopBar(),
          ],
        ),
      ),
    );
  }
}


class InputLocationWidget extends StatelessWidget {
  final void Function() onTapTujuan;
  final void Function() onTapJemput;
  final bool isEnabled;

  const InputLocationWidget({
    super.key,
    required this.onTapJemput,
    required this.onTapTujuan,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              spreadRadius: 4,
              blurRadius: 21,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: Color(0xFFF7FCF9),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 7,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: this.onTapJemput,
              child: Container(
                child: TextField(
                  enabled: this.isEnabled,
                  onTap: onTapJemput,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: Image.asset(
                      getImageAsset("titikJemput.png"),
                      scale: 3.0,
                    ),
                    hintText: "Titik Jemput",
                    fillColor: Colors.white70,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: this.onTapTujuan,
              child: Container(
                child: TextField(
                  enabled: this.isEnabled,
                  onTap: onTapTujuan,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: Image.asset(
                      getImageAsset("tujuan.png"),
                      scale: 3.0,
                    ),
                    hintText: "Lokasi Tujuan",
                    fillColor: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}