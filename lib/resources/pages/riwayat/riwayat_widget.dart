import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mangjek_app/app/extensions/constructor.dart' as cons;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
// Function will use if API is already done
// Future getReq() async {
//   try {
//     String url = "";

//     final response = await http.get(
//       Uri.parse(url),
//     );
//     var responseData = jsonDecode(response.body);
//     return responseData;
//   } catch (e) {
//     print(e);
//   }
// }

// function use during API is already dones

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(cons.sizePadding),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Text(
            "Riwayat Orderan Kamu",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          const SizedBox(height: 8),
          Text(
            "terus gunakan aplikasi Si Kuning yaa",
            style: TextStyle(color: Colors.black38, fontSize: 12.0),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: <Widget>[
                historyBox("Gang Buntu", "Masih diperjalanan", "10000"),
                historyBox("Gang Lampung 1", "Sedang diperjalanan", "5000"),
                historyBox("Gang Lampung 2", "Sedang diperjalanan", "7000"),
                historyBox("Gang Salam", "Sedang diperjalanan", "4000"),
                historyBox("Gang Jaya", "Sedang diperjalanan", "8000"),
                historyBox("Gang Buntu", "Sedang diperjalanan", "15000"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget historyBox(goalPlace, status, price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black12),
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(cons.assetsImgBikeLogo),
                    Text(
                      "   ${goalPlace}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              (status == "Masih diperjalanan")
                  ? Image.asset(cons.assetsImgOTW)
                  : Container()
            ],
          ),
          const SizedBox(height: 17.0),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black12)),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      status,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    Text(
                      "25 Januari 2023 15:00",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              Text(
                "RP${price}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }
}
