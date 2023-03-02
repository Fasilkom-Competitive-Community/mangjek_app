import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../login/login_widget.dart' as login;
import '../../../../app/extensions/constructor.dart' as cons;
import '../onboarding/second_onboarding_widget.dart' as second_onboarding;

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const login.Login(),
              ),
            ),
            child: const Text(
              "Skip",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: cons.sizePadding),
          alignment: Alignment.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx < 0) {
                Navigator.of(context).pushAndRemoveUntil(
                    cons.GeserKiri(
                        tujuan: const second_onboarding.SecondOnboarding()),
                    (route) => false);
              }
            },
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                SvgPicture.asset(
                  cons.assetsImgFirstSplashScreen,
                  width: cons.lebarGambarSplash,
                  height: cons.tinggiGambarSplash,
                ),
                const SizedBox(height: 30.0),
                Text(
                  cons.stringTitle,
                  style: TextStyle(
                      color: cons.colorTextSplash,
                      fontSize: cons.fontSize,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Aplikasi ojek online khusus mahasiswa unsri",
                  style: TextStyle(
                      color: cons.colorTextSplash,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(),
                    width: double.infinity,
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonPindah(
                          lebar: 40.0, tinggi: 5.0, warna: HexColor("#000000")),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0)),
                      ButtonPindah(
                          lebar: 20.0, tinggi: 5.0, warna: HexColor("#D9D9D9")),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0)),
                      ButtonPindah(
                          lebar: 20.0, tinggi: 5.0, warna: HexColor("#D9D9D9")),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  height: 80.0,
                  width: double.infinity,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: cons.lebarButtonSplashScreen),
                  height: cons.tinggiButtonSplashScreen,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cons.colorButtonSplash,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        cons.GeserKiri(
                            tujuan: const second_onboarding.SecondOnboarding()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Next ",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonPindah extends StatelessWidget {
  const ButtonPindah(
      {super.key,
      required this.lebar,
      required this.tinggi,
      required this.warna});
  final double lebar;
  final double tinggi;
  final Color warna;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lebar,
      height: tinggi,
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
