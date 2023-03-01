import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'reset_sandi.dart' as reset;
import '../register/register_widget.dart' as register;
import '../../../../app/extensions/constructor.dart' as cons;
// import '../../../../routes/router.dart' as main;
import '../../home/home_page.dart' as home_page;

FirebaseAuth _auth = FirebaseAuth.instance;
Stream<User?> get firebaseUserStream => _auth.authStateChanges();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool lihat = true;
  String showPasswordLogo = cons.assetsIconShowPassword;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  void lihatPassword() {
    setState(() {
      lihat = !lihat;
      if (lihat == false) {
        showPasswordLogo = cons.assetsIconEyeShowPassword;
      } else {
        showPasswordLogo = cons.assetsIconShowPassword;
      }
    });
  }

  Future<void> _login(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (userCredential.user!.emailVerified) {
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => home_page.HomePage(),
            ),
            (route) => false);
      } else {
        await _auth.signOut();
        popUpVerifikasi(
            "Heyyy 🥲",
            "Email yang kamu daftarkan belum terverifikasi",
            14,
            120,
            email,
            pass);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        popUp(
            "Hemmmm 🥲",
            "Kamu memasukkan Email yang salah, coba periksa kembali yaa",
            14,
            110);
      } else if (e.code == 'wrong-password') {
        popUp(
            "Hemmm 🧐",
            "Kamu memasukkan Kata Sandi yang salah, coba periksa kembali yaa",
            14,
            115);
      }
    } catch (e) {
      print(e);
      popUp(
        "Yahh Sorry 🥲",
        "Kamu belum bisa melakukan Login sekarang, sistem kami sedang dalam masalah",
        14,
        135,
      );
    }
  }

  void _validasiLogin(String emailAwal, String pass) {
    String email = emailAwal.trim();
    if (email.contains("@student.unsri.ac.id")) {
      if (pass.length >= 8 && pass.length <= 16) {
        _login(email, pass);
      } else {
        popUp(
            "Heyy 🥲",
            "Kata sandi yang kamu masukkan masih salah nihhh, Minimal 8 character, dan Maksimal 16 character lengkapi lagi yaa",
            14,
            150);
      }
    } else if (email.isEmpty && pass.isEmpty) {
      popUp(
          "Duhhh 😥",
          "Tidak ada data yang diisi, harap mengisi data dengan baik dan benar ya",
          14,
          110);
    } else {
      popUp(
          "Heyy 😥",
          "Email yang kamu masukan bukan email UNSRI, periksa kembali ok 👍",
          14,
          110);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            color: cons.colorBackgroundSplashTwo,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: cons.sizePadding),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        cons.assetsImgLogin,
                        width: cons.lebarGambarSplash,
                        height: cons.tinggiGambarSplash,
                      ),
                      const Text(
                        "Selamat Datang",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: cons.fontSize),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        "Pastikan Email dan Kata sandi yang kamu masukkan sudah terisi dengan benar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: cons.fontSizeSecond,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 55.0, 20.0, 40.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 45.0,
                        child: TextFormField(
                          controller: emailCont,
                          decoration: InputDecoration(
                            prefixIcon: SvgPicture.asset(
                              cons.assetsIconEmail,
                              color: cons.colorBackgroundSplashTwo,
                              fit: BoxFit.none,
                            ),
                            hintText: "Email unsri",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: "Email unsri",
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      SizedBox(
                        height: 45.0,
                        child: TextFormField(
                          controller: passCont,
                          obscureText: lihat,
                          decoration: InputDecoration(
                            prefixIcon: SvgPicture.asset(
                              cons.assetsIconPassword,
                              color: cons.colorBackgroundSplashTwo,
                              fit: BoxFit.none,
                            ),
                            hintText: "Kata Sandi",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: "Kata Sandi",
                            suffixIcon: ElevatedButton(
                              onPressed: () {
                                lihatPassword();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0),
                              child: SvgPicture.asset(
                                showPasswordLogo,
                                fit: BoxFit.none,
                                color: cons.colorBackgroundSplashTwo,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const reset.ResetSandi(),
                            ),
                          ),
                          child: const Text(
                            "Lupa kata sandi ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        height: 55.0,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 70.0),
                        child: ElevatedButton(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Masuk Sekarang",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            String email = emailCont.text.toString();
                            String pass = passCont.text.toString();
                            _validasiLogin(email, pass);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cons.colorBackgroundSplashTwo,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Belum punya akun? "),
                          SizedBox(
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const register.Register(),
                                      ),
                                      (route) => false),
                              child: Text(
                                "Daftar sekarang",
                                style: TextStyle(
                                    color: cons.colorBackgroundSplashTwo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void popUp(String judul, String isi, double font, double height) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: SvgPicture.asset(cons.assetsIconAlert),
          content: SizedBox(
            width: double.infinity,
            height: height,
            child: Column(
              children: <Widget>[
                Text(
                  judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  isi,
                  style: TextStyle(fontSize: font),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void popUpVerifikasi(String judul, String isi, double font, double height,
      String email, String pass) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: SvgPicture.asset(cons.assetsIconAlert),
          content: SizedBox(
            width: double.infinity,
            height: height,
            child: Column(
              children: <Widget>[
                Text(
                  judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "$isi,",
                  style: TextStyle(fontSize: font),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    _verifikasiEmail(email, pass);
                  },
                  child: Text(
                    "Kirim link verifikasi ulang",
                    style: TextStyle(
                        fontSize: font,
                        color: cons.colorBackgroundSplashTwo,
                        decoration: TextDecoration.underline),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _verifikasiEmail(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      await userCredential.user!.sendEmailVerification();
      await _auth.signOut();
      if (!mounted) return;
      Navigator.pop(context);
      popUp(
          "Sip 👍",
          "Link verifikasi telah terkirim ke email Kamu, silahkan cek dan segera melakukan verifikasi yaa",
          14,
          120);
    } on FirebaseAuthException catch (e) {
      return;
    }
  }
}
