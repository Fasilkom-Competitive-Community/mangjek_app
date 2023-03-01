import 'package:flutter/material.dart';
import './extentions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:nylo_framework/nylo_framework.dart';

class OjekTerpesan extends StatefulWidget {
  const OjekTerpesan({super.key});

  @override
  State<OjekTerpesan> createState() => _OjekTerpesanState();
}

class _OjekTerpesanState extends State<OjekTerpesan> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: '#FFFFFF'.toColor(),
      body: new Center(
        child: new Container(
          child: new Center(
            child: new Column(
              children: [
                new Expanded(
                    child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Image.asset("img/splashhome.png"),
                    new Padding(padding: new EdgeInsets.all(5.0)),
                    new Text(
                      "Horeee 🖐🏻",
                      style: new TextStyle(
                        fontSize: 24.0, color: '#1E1E1E'.toColor(), fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.center,
                    ),
                    new Padding(padding: new EdgeInsets.all(5.0)),
                    new Text(
                      "Kamu sudah sampai tujuan",
                      style: new TextStyle(
                        fontSize: 20.0, color: '#1E1E1E'.toColor(), fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                    new Text(
                      "Terima kasih sudah menggunakan Mangjek",
                      style: new TextStyle(
                        fontSize: 12.0, color: '#4B4B4B'.toColor(), fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 70.0),
                      child: new SizedBox(
                        width: 250.0,
                        height: 50.0,
                        child: new ElevatedButton(
                            style: ElevatedButton.styleFrom(shape: StadiumBorder(), backgroundColor: '#F3C703'.toColor()),
                            
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  "Kembali ke menu",
                                ),
                              ],
                            ),
                            onPressed: () => context
                      ),
                    ), ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}