import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangjek_app/app/constants/payment_methods.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  LatLng? titikJemput;
  LatLng? titikTujuan;
  late String namaLokasiJemput;
  late String namaLokasiTujuan;

  void setNamaLokasiJemput(String nama) {
    namaLokasiJemput = nama;
  }

  void setNamaLokasiTujuan(String nama) {
    namaLokasiTujuan = nama;
  }

  void changeSelectedPaymentMethod(PaymentMethods paymentMethods) {
    emit(OrderCreating(paymentMethods));
  }
}
