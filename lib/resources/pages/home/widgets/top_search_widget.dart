import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:nylo_framework/nylo_framework.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<String> lokasiSuggestions = ["Fasilkom, Indralaya", "FKIP, Indralaya"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 0)],
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Column(
        children: [
          // SizedBox(),
          // lokasi saat ini, pilih dari maps
          Container(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("img/location.png"),
                        Text("Lokasi saat ini")
                      ],
                    ),
                  ),
                )),
                Expanded(
                    child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("img/maps.png"),
                        Text("Pilih dari Maps")
                      ],
                    ),
                  ),
                )),
                // Text("data")
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            height: 145,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                const border = BorderSide(
                  color: Color(0xFFD4D8D6),
                );
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("tapped");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: (index == 0) ? border : BorderSide.none,
                          bottom: border,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Text(lokasiSuggestions[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}