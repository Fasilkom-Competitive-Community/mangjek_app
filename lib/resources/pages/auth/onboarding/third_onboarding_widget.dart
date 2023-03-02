import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../login/login_widget.dart' as login;
import '../onboarding/second_onboarding_widget.dart' as second_onboarding;
import '../../../../app/extensions/constructor.dart' as cons;

class ThirdOnboarding extends StatefulWidget {
  const ThirdOnboarding({super.key});

  @override
  State<ThirdOnboarding> createState() => _ThirdOnboardingState();
}

class _ThirdOnboardingState extends State<ThirdOnboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                cons.GeserKanan(
                    tujuan: const second_onboarding.SecondOnboarding()),
                (route) => false);
          },
        ),
        backgroundColor: cons.colorBackgroundSplashThree,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: cons.colorBackgroundSplashThree,
          ),
          padding: const EdgeInsets.symmetric(horizontal: cons.sizePadding),
          alignment: Alignment.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0) {
                Navigator.of(context).pushAndRemoveUntil(
                    cons.GeserKanan(
                      tujuan: const second_onboarding.SecondOnboarding(),
                    ),
                    (route) => false);
              }
              if (details.delta.dx < 0) {
                Navigator.push(
                  context,
                  cons.GeserKiri(
                    tujuan: const login.Login(),
                  ),
                );
              }
            },
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Image.asset(
                  cons.assetsImgThirdSpashScreen,
                  width: cons.lebarGambarSplash,
                  height: cons.tinggiGambarSplash,
                ),
                const SizedBox(height: 30.0),
                Text(
                  "Hi 🖐️",
                  style: TextStyle(
                      color: cons.colorTextSplash,
                      fontSize: cons.fontSize,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Selamat menempuh perjalanan di aplikasi MangJek",
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
                          lebar: 20.0, tinggi: 5.0, warna: HexColor("#D9D9D9")),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0)),
                      ButtonPindah(
                          lebar: 20.0, tinggi: 5.0, warna: HexColor("#D9D9D9")),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0)),
                      ButtonPindah(
                          lebar: 40.0, tinggi: 5.0, warna: HexColor("#000000")),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  height: 80.0,
                  width: double.infinity,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  height: cons.tinggiButtonSplashScreen,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () => Navigator.of(context)
                        .push(cons.GeserKiri(tujuan: const login.Login())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Next ",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonPindah extends StatelessWidget {
  const ButtonPindah({
    super.key,
    required this.lebar,
    required this.tinggi,
    required this.warna,
  });
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
      child: GestureDetector(
        onTap: () {},
      ),
    );
  }
}
