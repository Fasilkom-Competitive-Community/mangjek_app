import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// String {
const stringTitle = "Sikuning";
// }

// Size {
const sizePadding = 20.0;
const borderRadius = 14.0;
const tinggiButtonSplashScreen = 60.0;
const lebarButtonSplashScreen = 100.0;
const lebarGambarSplash = 280.0;
const tinggiGambarSplash = 200.0;
const fontSize = 20.0;
const fontSizeSecond = 14.0;
const fontPersetujuan = 13.0;
// }

// Assets {
const assetsImgFirstSplashScreen = "public/assets/images/take_away-pana_1.svg";
const assetsImgSecondSplashScreen = "public/assets/images/safety.svg";
const assetsImgThirdSpashScreen = "public/assets/images/sapiens_1.png";
const assetsImgBikeLogo = "public/assets/images/bike_logo.svg";
const assetsImgOTW = "public/assets/images/OTW.png";
const assetsChooseLocation = "public/assets/images/koor.png";
const assetsImgLogoSikuning = "public/assets/images/logo_sikuning.png";
const assetsImgTrashBin = "public/assets/images/trash_bin.svg";
const assetsImgMotor = "public/assets/images/motor_logo.svg";
const assetsImgLogin = "public/assets/images/logo_login.png";
const assetsImgRegister = "public/assets/images/bike.png";
const assetsImgVerifikasi = "public/assets/images/verifikasi_logo.svg";
const assetsImgResetPassword = "public/assets/images/reset_password_logo.svg";
const assetsIconEmail = "public/assets/images/sms.svg";
const assetsIconPassword = "public/assets/images/password.svg";
const assetsIconShowPassword = "public/assets/images/eye.svg";
const assetsIconEyeShowPassword = "public/assets/images/eye-show.svg";
const assetsIconAlert = "public/assets/images/alert_dialog.svg";
const assetsFontPrimary = "Poppins";
// }

// Colors {
var colorTextSplash = HexColor("#0F5356");
var colorButtonSplash = HexColor("#33BC51");
var colorBackgroundSplashTwo = HexColor("#F3C703");
var colorBackgroundSplashThree = HexColor("#33BC51");
var colorButtonNonActive = HexColor("#F3F5F9");

class GeserKiri extends PageRouteBuilder {
  final Widget tujuan;
  GeserKiri({required this.tujuan})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => tujuan,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: tujuan,
                    ));
}

class GeserKanan extends PageRouteBuilder {
  final Widget tujuan;
  GeserKanan({required this.tujuan})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => tujuan,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: tujuan,
          ),
        );
}

class FadePageTransition extends PageRouteBuilder {
  final Widget tujuan;

  FadePageTransition({
    required this.tujuan,
  }) : super(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => tujuan,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      FadeTransition(
        opacity: animation,
        child: child,
      );
}
