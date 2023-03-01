import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login/login_widget.dart' as login;
import '../../../../app/extensions/constructor.dart' as cons;

class ResetSandi extends StatefulWidget {
  const ResetSandi({super.key});

  @override
  State<ResetSandi> createState() => _ResetSandiState();
}

class _ResetSandiState extends State<ResetSandi> {
  TextEditingController emailCont = TextEditingController();

  Future<void> _resetPassword(String emailAwal) async {
    String email = emailAwal.trim();
    try {
      if (email.contains("@student.unsri.ac.id")) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (!mounted) return;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const login.Login(),
        ));
        popUp(
            "Heyy 🙂",
            "Silahkan cek email Kamu untuk melakukan reset password ya",
            16,
            120);
      } else if (email.isEmpty) {
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        popUp("Tidak ada akun", "Tidak ada akun", 16, 100);
      } // Belum jadi
    } catch (e) {
      popUp(
        "Oops 😔",
        "Mohon maaf untuk saat ini sistem Kami belum dapat memproses permintaan Anda",
        14,
        110,
      ); // Belum Jadi
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(cons.sizePadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  cons.assetsImgResetPassword,
                  width: 100.0,
                  height: 100.0,
                ),
                const SizedBox(height: 25),
                const Text(
                  "Kamu lupa kata sandi? 😣",
                  style: TextStyle(
                    fontSize: cons.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  "verifikasi ulang dengan memasukkan email yang kamu daftarkan yaa",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
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
                const SizedBox(height: 260),
                Container(
                  height: 55.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _resetPassword(emailCont.text.toString());
                      setState(() {
                        emailCont.text = "";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cons.colorBackgroundSplashTwo,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                    ),
                    child: const Text(
                      "Verifikasi Sekarang",
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
      ),
    );
  }
}
