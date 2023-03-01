import 'package:flutter/material.dart';
import 'package:mangjek_app/app/extensions/string.dart';

class Pembayaran extends StatefulWidget {
  const Pembayaran({super.key});

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // kamu mau pergi
        // buildPesanSekarang(),
        Container(
          height: 735.0,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 0)],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0))),
          child: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
                      // Text("Lokasi Jemput", style: TextStyle(fontWeight: FontWeight.w700),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Pilih metode pembayaran",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Metode pembayaran utama",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        "img/tunai.png",
                                        scale: 3.0,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                          Text(
                                            "Tunai",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                          Text(
                                            "Siapkan uang pas kamu, biar gak perlu",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                          Text(
                                            "nunggu kembalian lagi.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Expanded(child: SizedBox.fromSize()),
                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Padding(padding: EdgeInsets.only(right: 5)),
                                      Image.asset(
                                        "img/radio-active.png",
                                        scale: 3.5,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFD4D8D6),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Metode pembayaran lainnya", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Image.asset(
                        "img/dana.png",
                        scale: 3.0,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        "Dana",
                        style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Image.asset(
                        "img/ovo.png",
                        scale: 3.0,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        "Ovo",
                        style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Image.asset(
                        "img/shopeepay.png",
                        scale: 3.0,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        "Shopeepay",
                        style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                width: 300.0,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: '#F3C703'.toColor()),
                  child: const Text("Lanjutkan"),
                  onPressed: (() => context),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            ],
          ),
        ),
      ],
    );
  }
}