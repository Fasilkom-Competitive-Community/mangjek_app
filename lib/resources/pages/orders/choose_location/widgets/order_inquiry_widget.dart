import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/globals/init.dart';
import 'package:mangjek_app/app/bloc/order/order_cubit.dart';
import 'package:mangjek_app/app/constants/payment_methods.dart';
import 'package:mangjek_app/app/controllers/controller.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:mangjek_app/resources/pages/orders/qris/qr_code_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class OrderInquiryWidget extends NyStatefulWidget {
  final Controller controller = Controller();
  final OrderCubit orderCubit;

  OrderInquiryWidget({
    super.key,
    required this.orderCubit,
  });

  @override
  State<OrderInquiryWidget> createState() => _OrderInquiryWidgetState();
}

class _OrderInquiryWidgetState extends NyState<OrderInquiryWidget> {
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
                                        Image.asset(
                                          getImageAsset("motor.png"),
                                          width: 34,
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
                  BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Image.asset(
                                state.selectedPaymentMethod.assetPath,
                                width: 30,
                                height: 30,
                              ),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              const Text(
                                "Metode Pembayaran",
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          Expanded(child: SizedBox.fromSize()),
                          Row(
                            children: [
                              Text(
                                state.selectedPaymentMethod.value,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              InkWell(
                                onTap: () async {
                                  await showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30.0),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    backgroundColor: Colors.white,
                                    isScrollControlled: true,
                                    // maxHeight: MediaQuery.of(context).size.height * 0.8,
                                    builder: (BuildContext context) {
                                      return Container(
                                        // height: MediaQuery.of(context).size.height,
                                        child: bottomSheetPrice(),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  child: Image.asset(
                                    getImageAsset("more.png"),
                                    scale: 3.0,
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                            ],
                          )
                        ],
                      );
                    },
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
                  child: const Text("Lanjutkan"),
                  onPressed: () {
                    if (orderCubit.state.selectedPaymentMethod ==
                        PaymentMethods.QRIS) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodePage(),
                        ),
                      );
                    }
                  },
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

  final Image activePaymentMethodDotImage = Image.asset(
    "public/assets/images/radio-active.png",
    scale: 3.5,
  );

  @override
  init() {
    return super.init();
  }

  Widget bottomSheetPrice() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
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
                                      fontSize: 18,
                                    ),
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
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  widget.orderCubit.changeSelectedPaymentMethod(
                                      PaymentMethods.CASH);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            PaymentMethods.CASH.assetPath,
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
                                                  horizontal: 5,
                                                ),
                                              ),
                                              Text(
                                                PaymentMethods.CASH.value,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                              ),
                                              Text(
                                                "Siapkan uang pas kamu, biar gak perlu",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                ),
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
                                      BlocBuilder<OrderCubit, OrderState>(
                                        builder: (context, state) {
                                          return state.selectedPaymentMethod ==
                                                  PaymentMethods.CASH
                                              ? Container(
                                                  child:
                                                      activePaymentMethodDotImage,
                                                )
                                              : const SizedBox();
                                        },
                                      )
                                    ],
                                  ),
                                ),
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
                  Text(
                    "Metode pembayaran lainnya",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  widget.orderCubit
                      .changeSelectedPaymentMethod(PaymentMethods.QRIS);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Image.asset(
                                PaymentMethods.QRIS.assetPath,
                                scale: 3.0,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Text(PaymentMethods.QRIS.value,
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox.fromSize()),
                      BlocBuilder<OrderCubit, OrderState>(
                        builder: (context, state) {
                          return state.selectedPaymentMethod ==
                                  PaymentMethods.QRIS
                              ? Container(child: activePaymentMethodDotImage)
                              : const SizedBox();
                        },
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: SizedBox()),
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
                  child: const Text("Konfirmasi"),
                  onPressed: (() {
                    pop();
                  }),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            ],
          ),
        ),
      ],
    );
    //
  }
}
