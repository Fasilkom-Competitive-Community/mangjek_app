import 'package:flutter/material.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:nylo_framework/nylo_framework.dart';

class BottomPesan extends StatefulWidget {
  final double paddingBottom;
  const BottomPesan({super.key, required this.paddingBottom});

  @override
  State<BottomPesan> createState() => _BottomPesanState();
}

class _BottomPesanState extends NyState<BottomPesan> {
  Widget buildKamuMauPergi() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Color(0xFFF3C703),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "😀🤚🏻",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Kamu Mau Pergi?",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            Text(
              "Buruan isi alamatnya, segera berangakat deh",
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // kamu mau pergi
        buildKamuMauPergi(),
        // ojeknya mangjek
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ).copyWith(
            bottom: widget.paddingBottom,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    getImageAsset("ojek.png"),
                                    scale: 3.0,
                                    width: 90,
                                  ),
                                ],
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                      ),
                                      Text(
                                        "Ojeknya Mangjek",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5)),
                                      Text(
                                        "Akan membantu kamu untuk",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5)),
                                      Text(
                                        "mengantar pergi & pulang ngampus",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                      )),
                                      Text(
                                        "Nantikan fitur terbaru mangjek ya",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300.0,
                height: 45.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: '#F3C703'.toColor(),
                  ),
                  child: const Text("Pesan Sekarang"),
                  onPressed: (() => context),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
