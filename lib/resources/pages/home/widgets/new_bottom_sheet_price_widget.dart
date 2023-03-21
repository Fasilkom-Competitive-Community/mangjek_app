import 'package:flutter/material.dart';
import 'package:mangjek_app/app/extensions/string.dart';

class Price extends StatefulWidget {
  const Price({super.key});

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  Widget buildBottomBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // kamu mau pergi
        // buildPesanSekarang(),
        Container(
          // height: 100.0,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 0)],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14.0),
                  topLeft: Radius.circular(14.0))),
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
                        child: Card(
                          color: '#F7FCF9'.toColor(),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: '#33BC51'.toColor(),
                              ),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset("img/motor.png"),
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
                                              "Motor",
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
                                              "Driver jemput : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              "3-7 menit",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5)),
                                            Text(
                                              "Jarak : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              "3,2 KM",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Expanded(child: SizedBox.fromSize()),
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        // Padding(padding: EdgeInsets.only(right: 5)),
                                        Text(
                                          "Rp 10.000",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Row(
                    children: [
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Image.asset(
                            "img/pembayaran.png",
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(
                            "Metode Pembayaran",
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox.fromSize()),
                      Row(
                        children: [
                          Text(
                            "Tunai",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Image.asset(
                            "img/more.png",
                            scale: 3.0,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                        ],
                      )
                    ],
                  ),
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFFF3C703))
                      // backgroundColor: Color(0xFFF3C703),
                      ),
                  child: const Text("Pesan Sekarang"),
                  onPressed: (() => context),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(color: Color(0xFFF3C703))),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFFFFFFFF))
                      // backgroundColor: Color(0xFFF3C703),
                      ),
                  child: const Text(
                    "Batalkan",
                    style: TextStyle(color: Color(0xFF1E1E1E)),
                  ),
                  onPressed: (() => context),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [buildBottomBar()],
        ),
      ),
    );
  }
}
