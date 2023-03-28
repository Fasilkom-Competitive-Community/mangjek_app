import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

// import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final controller = TextEditingController();

  Future<void> saveImage(Uint8List uint8list, String fileName) async {
    final directory = await getExternalStorageDirectory();

    final imageFile = File('${directory!.path}/$fileName');

    await imageFile.writeAsBytes(uint8list);

    final savedImage = await GallerySaver.saveImage(imageFile.path);

    print('Saved Image: $savedImage');
  }

  Widget buildQRSheet() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.arrow_back),
            ),
          ),
          Padding(padding: EdgeInsets.all(30)),
          Align(alignment: Alignment.center, child: QRCode()),
          SizedBox(
            height: 50,
          ),
          Text(
            "Ketentuan",
            style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              Container(
                width: 20,
                child: Image.asset(
                  getImageAsset("download.png"),
                  scale: 3.0,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              const Expanded(child: Text("Download QR code kamu"))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              Container(
                width: 20,
                child: Image.asset(
                  getImageAsset("hp.png"),
                  scale: 3.0,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              const Expanded(
                child: Text(
                  "Kemudian scan menggunakan e-wallet seperti dana, ovo, atau lainnya",
                  softWrap: true,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              Container(
                width: 20,
                child: Image.asset(
                  getImageAsset("motorcycle.png"),
                  scale: 3.0,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
              const Expanded(
                child: Text(
                  "Driver akan terpesan setelah pembayaran berhasil",
                  softWrap: true,
                ),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
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
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFF3C703))
                  // backgroundColor: Color(0xFFF3C703),
                  ),
              child: const Text("Download"),
              onPressed: () async {
                final image = await QrPainter(
                  data: "qrData",
                  version: QrVersions.auto,
                  gapless: false,
                  color: Colors.black,
                  emptyColor: Colors.white,
                ).toImage(200);

                final pngBytes =
                    await image.toByteData(format: ImageByteFormat.png);

                await saveImage(pngBytes!.buffer.asUint8List(), "qrcode.jpg");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "QR Code telah di download. Silahkan buka galeri anda"),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget QRCode() {
    return QrImage(
      data: "qrData",
      version: QrVersions.auto,
      size: 250.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            buildQRSheet(),
          ],
        ),
      ),
    );
  }
}
