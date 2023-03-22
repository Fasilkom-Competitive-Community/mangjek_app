import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class InputLocationWidget extends StatelessWidget {
  final void Function() onTapTujuan;
  final void Function() onTapJemput;

  const InputLocationWidget({
    super.key,
    required this.context,
    required this.onTapJemput,
    required this.onTapTujuan,
  });

  final BuildContext context;

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
            Container(
              child: TextField(
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
            const SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
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
          ],
        ),
      ),
    );
  }
}
