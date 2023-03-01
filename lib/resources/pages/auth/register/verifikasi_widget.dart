import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../app/extensions/constructor.dart' as cons;
import '../login/login_widget.dart' as login;

class Verifikasi extends StatefulWidget {
  const Verifikasi({super.key});

  @override
  State<Verifikasi> createState() => _VerifikasiState();
}

class _VerifikasiState extends State<Verifikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(cons.sizePadding),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                cons.assetsImgVerifikasi,
                width: 110.0,
                height: 110.0,
              ),
              const SizedBox(height: 25),
              const Text(
                "Yesss 😁",
                style: TextStyle(
                  fontSize: cons.fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Kamu berhasil terdaftar menjadi salah satu customer MangJek",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25.0),
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: HexColor("#FAE897"),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Text(
                  "Jangan lupa verifikasi akun mu, dengan buka email yang sudah kamu daftarkan dan klik link verifikasinya.",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 190),
              Container(
                height: 55.0,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const login.Login(),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cons.colorBackgroundSplashTwo,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                  child: const Text(
                    "Masuk Sekarang",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
