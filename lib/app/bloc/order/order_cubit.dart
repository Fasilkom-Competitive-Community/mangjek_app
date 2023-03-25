import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  late LatLng titikJemput;
  late LatLng titikTujuan;
  late String namaLokasiJemput;
  late String namaLokasiTujuan;

  void setNamaLokasiJemput(String nama) {
    namaLokasiJemput = nama;
  }

  void setNamaLokasiTujuan(String nama) {
    namaLokasiTujuan = nama;
  }
}
