import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'verifikasi.dart' as verifikasi;
import '../../../../app/extensions/constructor.dart' as cons;
import '../../auth/register/verifikasi_widget.dart' as verifikasi;
import '../login/login_widget.dart' as login;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool lihat1 = true;
  bool lihat2 = true;
  bool nilaiSetuju = false;
  String showPasswordLogo = cons.assetsIconShowPassword;
  String showPasswordLogo1 = cons.assetsIconShowPassword;
  String agreement = "public/assets/images/tick-circle.svg";

  TextEditingController emailCont = TextEditingController();
  TextEditingController passContFirst = TextEditingController();
  TextEditingController passContSec = TextEditingController();

  void lihatPassword1() {
    setState(() {
      lihat2 = !lihat2;
      if (lihat2 == false) {
        showPasswordLogo1 = cons.assetsIconEyeShowPassword;
      } else {
        showPasswordLogo1 = cons.assetsIconShowPassword;
      }
    });
  }

  void lihatPassword() {
    setState(() {
      lihat1 = !lihat1;
      if (lihat1 == false) {
        showPasswordLogo = cons.assetsIconEyeShowPassword;
      } else {
        showPasswordLogo = cons.assetsIconShowPassword;
      }
    });
  }

  Future<void> _signUp(String email, String pass) async {
    try {
      setState(() {
        emailCont.text = "";
        passContFirst.text = "";
        passContSec.text = "";
        nilaiSetuju = false;
        agreement = "public/assets/images/tick-circle.svg";
        print("Hello masuk");
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      await userCredential.user!.sendEmailVerification();
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const verifikasi.Verifikasi(),
          transitionDuration: const Duration(milliseconds: 100),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        popUp(
            "heyy 🥲",
            "Email yang kamu masukkan sudah terdaftar coba kembali dengan email yang berbeda ya",
            14,
            130);
      }
    } catch (e) {
      popUp(
        "Yahh Sorry 🥲",
        "Kamu belum bisa melakukan Register sekarang, sistem kami sedang dalam perbaikan",
        14,
        135,
      );
    }
  }

  void _validasiRegister(String emailAwal, String passFirst, String passSec) {
    String email = emailAwal.trim();
    if (email.contains("@student.unsri.ac.id")) {
      if (passFirst == passSec) {
        if (passFirst.length >= 8 && passFirst.length <= 16) {
          if (nilaiSetuju == true) {
            _signUp(email, passFirst);
          } else {
            popUp(
                "heyy🧐",
                'Kamu belum menceklist “Setuju dengan aturan dan kebijakan aplikasi”',
                14,
                110);
          }
        } else {
          popUp(
              "Heyy 🥲",
              "Kata sandi yang kamu masukkan masih salah nihhh, Minimal 8 character, dan Maksimal 16 character lengkapi lagi yaa",
              14,
              150);
        }
      } else {
        popUp(
            "Heyy 🧐",
            "Kata sandi yang kamu masukan tidak sama, pastikan kata sandi dan konfirmasi kata sandi harus sama ya",
            14,
            130);
      }
    } else if (email.isEmpty && passFirst.isEmpty && passSec.isEmpty) {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.all(cons.sizePadding),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Image.asset(
                  cons.assetsImgRegister,
                  width: cons.lebarGambarSplash,
                  height: cons.tinggiGambarSplash,
                ),
                const Text(
                  "Halo 😇",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: cons.fontSize,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: const Text(
                    "Selamat datang di aplikasi ojek online untuk mahasiswa Universitas Sriwijaya",
                    style: TextStyle(
                      fontSize: cons.fontSizeSecond,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
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
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                SizedBox(
                  height: 45.0,
                  child: TextFormField(
                    controller: passContFirst,
                    obscureText: lihat1,
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
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon: ElevatedButton(
                        onPressed: () {
                          lihatPassword();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, elevation: 0),
                        child: SvgPicture.asset(
                          showPasswordLogo,
                          fit: BoxFit.none,
                          color: cons.colorBackgroundSplashTwo,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                SizedBox(
                  height: 45.0,
                  child: TextFormField(
                    controller: passContSec,
                    obscureText: lihat2,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        cons.assetsIconPassword,
                        color: cons.colorBackgroundSplashTwo,
                        fit: BoxFit.none,
                      ),
                      contentPadding: const EdgeInsets.all(10.0),
                      hintText: "Konfirmasi Kata Sandi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      labelText: "Konfirmasi Kata Sandi",
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon: ElevatedButton(
                        onPressed: () {
                          lihatPassword1();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, elevation: 0),
                        child: SvgPicture.asset(
                          showPasswordLogo1,
                          fit: BoxFit.none,
                          color: cons.colorBackgroundSplashTwo,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          nilaiSetuju = !nilaiSetuju;
                          if (nilaiSetuju == true) {
                            agreement =
                                "public/assets/images/tick-circle-done.svg";
                          } else {
                            agreement = "public/assets/images/tick-circle.svg";
                          }
                        });
                      },
                      child: SvgPicture.asset(
                        agreement,
                        width: 20.0,
                      ),
                    ),
                    const Text(
                      " Setuju dengan ",
                      style: TextStyle(fontSize: cons.fontPersetujuan),
                    ),
                    SizedBox(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "aturan ",
                          style: TextStyle(
                              fontSize: cons.fontPersetujuan,
                              color: cons.colorBackgroundSplashTwo),
                        ),
                      ),
                    ),
                    const Text(
                      "dan ",
                      style: TextStyle(fontSize: cons.fontPersetujuan),
                    ),
                    SizedBox(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "kebijakan aplikasi",
                          style: TextStyle(
                              fontSize: cons.fontPersetujuan,
                              color: cons.colorBackgroundSplashTwo),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Container(
                  height: 55.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: ElevatedButton(
                    onPressed: () {
                      String email = emailCont.text.toString();
                      String passFirst = passContFirst.text.toString();
                      String passSec = passContSec.text.toString();
                      _validasiRegister(email, passFirst, passSec);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cons.colorBackgroundSplashTwo,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(cons.borderRadius)),
                    ),
                    child: const Text(
                      "Daftar Sekarang",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Sudah punya akun? "),
                    SizedBox(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const login.Login(),
                            ),
                            (route) => false),
                        child: Text(
                          "Masuk segera",
                          style:
                              TextStyle(color: cons.colorBackgroundSplashTwo),
                        ),
                      ),
                    ),
                  ],
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
        });
  }
}
