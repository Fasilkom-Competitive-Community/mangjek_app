import 'package:flutter/material.dart';
import 'package:mangjek_app/app/extensions/string.dart';

class DataDriver extends StatefulWidget {
  const DataDriver({super.key});

  @override
  State<DataDriver> createState() => _DataDriverState();
}

class _DataDriverState extends State<DataDriver> {
  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // kamu mau pergi
          // buildPesanSekarang(),
          Container(
            // height: 100.0,
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
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          "Data Driver",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
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
                                    Column(
                                      children: [
                                        Image.asset("img/driver.png"),
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
                                              "M. Farhan Ghifari",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
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
                                              "Mahasiswa Teknik Informatika...",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(child: SizedBox.fromSize()),
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        // Padding(padding: EdgeInsets.only(right: 5)),
                                        Image.asset(
                                          "img/call.png",
                                          scale: 3.2,
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
                                    Column(
                                      children: [
                                        Image.asset(
                                          "img/motor2.png",
                                          scale: 3.5,
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
                                              "Motor",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5)),
                                            Text(
                                              "Honda",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              " Revo",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
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
                                              "Jarak",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              " 3,2 KM",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(child: SizedBox.fromSize()),
                                    Column(
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        // Padding(padding: EdgeInsets.only(right: 5)),
                                        Text(
                                          "BG - 8654 A",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
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
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            color: '#FFFFFF'.toColor(),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: '#EBEFED'.toColor(),
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                        left: 10,
                                      )),
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10)),
                                              Text(
                                                "Rp 10.000",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      Row(
                                        children: [
                                          Text(
                                            "| \t Tunai",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  ],
                )),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 5)),
                    Text(
                      "Rute perjalanan",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                        Image.asset(
                          "img/titikjemput.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Text(
                          "Fasilkom, Indralaya",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 17)),
                        Image.asset(
                          "img/vector.png",
                          scale: 3.0,
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                        Image.asset(
                          "img/tujuan.png",
                          scale: 3.0,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        Text(
                          "Gang Buntu",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Text(
                      "Status pesanan",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                  vertical: 5,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No. pesanan",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Text(
                          "Status pesanan",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Text(
                          "Tanggal",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Si Kuning92817273718",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8)),
                            Image.asset(
                              "img/copy.png",
                              scale: 3.0,
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Text(
                          "Pesanan sedang berjalan",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: '#A3A3A3'.toColor()),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Text(
                          "08-02-2023  14.12 WIB",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: '#A3A3A3'.toColor()),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Text(
                      "Pusat bantuan",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                  vertical: 5,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Customer Service",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Via Whatsapp",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5)),
                            Image.asset(
                              "img/whatsapp.png",
                              scale: 3.0,
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                  vertical: 10,
                )),
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: '#F3C703'.toColor()),
                    child: const Text("Batalkan pesanan?"),
                    onPressed: (() => context),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                  vertical: 10,
                )),
                Text(
                  "Jangan lupa pakai helm",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Text(
                  "dan semoga selamat sampai tujuan ya.",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                  vertical: 5,
                )),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
