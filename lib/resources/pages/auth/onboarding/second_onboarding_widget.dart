import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../login/login_widget.dart' as login;
import '../onboarding/first_onboarding_widget.dart' as first_onboarding;
import '../onboarding/third_onboarding_widget.dart' as third_onboarding;
import '../../../../app/extensions/constructor.dart' as cons;

class SecondOnboarding extends StatefulWidget {
  const SecondOnboarding({super.key});

  @override
  State<SecondOnboarding> createState() => _SecondOnboardingState();
}

class _SecondOnboardingState extends State<SecondOnboarding> {
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
                cons.GeserKanan(tujuan: const first_onboarding.OnBoarding()),
                (route) => false);
          },
        ),
        backgroundColor: cons.colorBackgroundSplashTwo,
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
          decoration: BoxDecoration(
            color: cons.colorBackgroundSplashTwo,
          ),
          padding: const EdgeInsets.symmetric(horizontal: cons.sizePadding),
          alignment: Alignment.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0) {
                Navigator.of(context).pushAndRemoveUntil(
                    cons.GeserKanan(
                        tujuan: const first_onboarding.OnBoarding()),
                    (route) => false);
              }
              if (details.delta.dx < 0) {
                Navigator.of(context).pushAndRemoveUntil(
                    cons.GeserKiri(
                        tujuan: const third_onboarding.ThirdOnboarding()),
                    (route) => false);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  cons.assetsImgSecondSplashScreen,
                  width: cons.lebarGambarSplash,
                  height: cons.tinggiGambarSplash,
                ),
                const SizedBox(height: 30.0),
                Text(
                  "Safety",
                  style: TextStyle(
                      color: cons.colorTextSplash,
                      fontSize: cons.fontSize,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Dengan para driver mahasiwa, dijamin perjalananmu menjadi lebih aman",
                  style: TextStyle(
                      color: cons.colorTextSplash,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Container(
                  decoration: const BoxDecoration(),
                  height: 130.0,
                  width: double.infinity,
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
                          lebar: 40.0, tinggi: 5.0, warna: HexColor("#000000")),
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
                      // Navigator.push(
                      //   context,
                      //   cons.GeserKiri(
                      //       tujuan: const third_splash_screen.SplashScreen()),
                      // );
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
