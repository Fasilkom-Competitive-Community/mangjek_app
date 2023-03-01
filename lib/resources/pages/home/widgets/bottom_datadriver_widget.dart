import 'package:flutter/material.dart';
import './extentions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:nylo_framework/nylo_framework.dart';


class DataDriver extends StatefulWidget {
  const DataDriver({super.key});

  @override
  State<DataDriver> createState() => _DataDriverState();
}

class _DataDriverState extends State<DataDriver> {
  @override
  Widget build(BuildContext context) {
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
                      Text("Data Driver", style: TextStyle(fontWeight: FontWeight.w400),)
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
                                                  fontWeight: FontWeight.w500, fontSize: 12),
                                            ),
                                          ],
                                        ),Row(
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
                                        Image.asset("img/call.png", scale: 3.2,)
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
                                        Image.asset("img/motor2.png", scale: 3.5,),
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
                                                  fontWeight: FontWeight.w600, fontSize: 14),
                                            ),
                                          ],
                                        ),Row(
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
                                          ), Row(
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
                                        Text("BG - 8654 A", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)
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
                                                    left: 10,)),
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
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(child: SizedBox(
                                    )),
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
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 10))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            ],
          ),
        ),
      ],
    );
  }
}