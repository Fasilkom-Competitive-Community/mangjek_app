import 'dart:developer';

import 'package:flutter/material.dart';

class NewTopBarHome extends StatefulWidget {
  const NewTopBarHome({super.key});

  @override
  State<NewTopBarHome> createState() => _NewTopBarHomeState();
}

class _NewTopBarHomeState extends State<NewTopBarHome> {
  
  FocusNode focusNodeTitikJemput = FocusNode();
  FocusNode focusNodeLokasiTujuan = FocusNode();

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
                      bottomRight: Radius.circular(30))),
              child: Stack(
                children: [
                  _buildTopBar(),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 70.0,
          child: Container(
            child: buildSearch(),
          ),
        )
      ],
    );
  }

  Widget _buildTopBar() {
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
            // boxShadow: [BoxShadow(blurRadius: 0)],
            // borderRadius: BorderRadius.only(
            //     bottomRight: Radius.circular(30.0),
            //     bottomLeft: Radius.circular(30.0))
          ),
          child: Column(
            children: [
              Container(
                // color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    // horizontal: 10,
                    ),
                child: Row(
                  children: [
                    Image.asset("img/profile.png"),
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
                      "img/logo-2.png",
                      scale: 3.0,
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: 50,
              // )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSearch() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      // height: 120.0,
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
            Container(
              // padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: TextField(
                focusNode: focusNodeTitikJemput,
                // style: TextStyle(color: Colors.pinkAccent, height:
                //     MediaQuery.of(context).size.height/80),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: Image.asset(
                      "img/titikjemput.png",
                      scale: 3.0,
                    ),
                    hintText: "Titik Jemput",
                    fillColor: Colors.white70),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
              child: TextField(
                focusNode: focusNodeLokasiTujuan,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    prefixIcon: Image.asset(
                      "img/tujuan.png",
                      scale: 3.0,
                    ),
                    hintText: "Lokasi Tujuan",
                    fillColor: Colors.white70),
              ),
            ),
          ],
        ),
      ),
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