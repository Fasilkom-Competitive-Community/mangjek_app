import 'dart:developer';

import 'package:flutter/material.dart';

class HomePesan extends StatefulWidget {
  const HomePesan({super.key});

  @override
  State<HomePesan> createState() => _HomePesanState();
}

class _HomePesanState extends State<HomePesan> {

  FocusNode focusNodeTitikJemput = FocusNode();
  FocusNode focusNodeLokasiTujuan = FocusNode();

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // kamu mau pergi
          buildPesanSekarang(),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    spreadRadius: 4,
                    blurRadius: 21,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      "img/ojek.png",
                                      scale: 3.6,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Ojeknya Sikuning",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Akan membantu kamu untuk mengantar pergi & pulang ngampus",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Nantikan fitur terbaru mangjek ya",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Color(0xFF8C8C8C),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(Color(0xFFF3C703))
                        ),
                    child: const Text("Pesan Sekarang"),
                    onPressed: (() => context),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPesanSekarang() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Color(0xFFF3C703),
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
              vertical: 8,
            )),
            Text(
              "😀🤚🏻",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Kamu Mau Pergi?",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Buruan isi alamatnya, segera berangakat deh",
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              "Metode Pembayaran",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Color(0xFFFAE897),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "img/ceklist.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 6)),
                        Text(
                          "Tunai",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Card(
                  color: Color(0xFFFAE897),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "img/ceklist.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 6)),
                        Text(
                          "QRIS",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Card(
                  color: Color(0xFFFAE897),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "img/ceklist.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 6)),
                        Text(
                          "Dana",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

   Widget conditionalBuildBottomBar() {
    // print("lokasi tujuan : ${focusNodeLokasiTujuan.hasPrimaryFocus}");
    // print("lokasi jemput : ${focusNodeTitikJemput.hasPrimaryFocus}");
    return !focusNodeLokasiTujuan.hasFocus && !focusNodeTitikJemput.hasFocus
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 70,
              ),
              child: buildBottomBar(),
            ),
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            conditionalBuildBottomBar(),
          ],
        ),
      ),
    );
  }
}