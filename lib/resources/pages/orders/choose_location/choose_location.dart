import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:mangjek_app/app/bloc/order/order_cubit.dart';
import 'package:mangjek_app/app/constants/choose_location.dart';
import 'package:mangjek_app/app/controllers/controller.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:mangjek_app/app/networking/gmaps_service.dart';
import 'package:mangjek_app/app/singleton/location_plugin.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/bootstrap/helpers.dart';
import 'package:mangjek_app/resources/widgets/input_location_widget.dart';
import 'package:mangjek_app/resources/widgets/pile_button_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import 'package:location/location.dart';
import 'package:mangjek_app/app/utils/debouncer.dart';

class ChooseLocation extends NyStatefulWidget {
  ChooseLocation({super.key});

  final Controller controller = Controller();

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

LatLng initCameraLocation = LatLng(-3.2189977434045636, 104.65166153632049);

class _ChooseLocationState extends NyState<ChooseLocation> {
  late ChooseLocationType prevClickOnType;
  late SelectLocationCubit selectLocationCubit;
  String lokasi = "";
  List<dynamic> lokasiSuggestions = [];
  Debouncer onTextChangeJemput = Debouncer(milliseconds: 1000);
  Debouncer onTextChangeTujuan = Debouncer(milliseconds: 1000);

  late OrderCubit _orderCubit;

  final TextEditingController controllerInputTitikJemput =
      TextEditingController();
  final TextEditingController controllerInputTitikTujuan =
      TextEditingController();

  final FocusNode titikJemputFocusNode = FocusNode();
  final FocusNode titikTujuanFocusNode = FocusNode();

  bool isFocusOnTitikJemput() {
    return titikJemputFocusNode.hasFocus;
  }

  bool isFocusOnTitikTujuan() {
    return titikTujuanFocusNode.hasFocus;
  }

  Future<List<dynamic>> _getSuggestion(String input) async {
    final response =
        await api<GmapService>((req) => req.fetchSuggestionData(input));
    setState(() {});
    print(response);
    return response['predictions'];
  }

  Future<LatLng> _getLatLangFromMapId(String loc) async {
    final response =
        await api<GmapService>((req) => req.getLatLangFromMapId(loc));
    Map<String, dynamic> locationObject =
        response['result']['geometry']['location'];
    return LatLng(locationObject['lat'], locationObject['lng']);
  }

  void _onTextChangeJemput(String value) {
    onTextChangeJemput.run(() async {
      lokasiSuggestions = await _getSuggestion(value);
      setState(() {});
    });
  }

  void _onTextChangeTujuan(String value) {
    onTextChangeTujuan.run(() async {
      lokasiSuggestions = await _getSuggestion(value);
      setState(() {});
    });
  }

  void _onTapLokasiSaatIni() {
    selectLocationCubit.lastIndexFocused == 0
        ? selectLocationCubit.setLocTitikJemput(lokasi)
        : selectLocationCubit.setLocTitikTujuan(lokasi);
  }

  void _onTapSuggestion(String id, String nama) async {
    LatLng titikLokasi = await _getLatLangFromMapId(id);
    if (isFocusOnTitikJemput()) {
      _orderCubit.titikJemput = titikLokasi;
      _orderCubit.setNamaLokasiJemput(nama);
      controllerInputTitikJemput.text = nama;
    }
    if (isFocusOnTitikTujuan()) {
      _orderCubit.titikTujuan = titikLokasi;
      _orderCubit.setNamaLokasiTujuan(nama);
      controllerInputTitikTujuan.text = nama;
    }
  }

  @override
  init() {
    prevClickOnType = widget.data() as ChooseLocationType;
    return super.init();
  }

  @override
  void dispose() {
    controllerInputTitikJemput.dispose();
    controllerInputTitikTujuan.dispose();
    titikJemputFocusNode.dispose();
    titikTujuanFocusNode.dispose();
    super.dispose();
  }

  Widget _buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initCameraLocation,
        zoom: 16.5,
      ),
    );
  }

  Widget _buildInputLocation() {
    return Container(
      height: 22.h,
      child: Stack(
        children: [
          Container(
            height: 14.h,
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            alignment: Alignment(0, -0.1.h),
            decoration: BoxDecoration(
              color: "#F3C703".toColor(),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    pop();
                  },
                  icon: Image.asset(
                    getImageAsset("arrow-back.png"),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              children: [
                InputLocationWidget(
                  context: context,
                  onChangeJemput: (val) => _onTextChangeJemput(val),
                  onChangeTujuan: (val) => _onTextChangeTujuan(val),
                  onTapJemput: () {},
                  onTapTujuan: () {},
                  focusNodeTitikJemput: titikJemputFocusNode,
                  focusNodeTitikTujuan: titikTujuanFocusNode,
                  textControllerTitikJemput: controllerInputTitikJemput,
                  textControllerTitikTujuan: controllerInputTitikTujuan,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChooseLocation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 6.w,
      ),
      child: Column(
        children: [
          // build  choose from current location and from map
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PileButtonWidget(
                iconLocation: "choose_location.png",
                label: "Lokasi saat ini",
                onTap: () {
                  log("test");
                },
              ),
              PileButtonWidget(
                iconLocation: "maps.png",
                label: "Pilih dari maps",
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          // build suggested location list
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var i = 0; i < lokasiSuggestions.length; i++)
                  Container(
                      width: MediaQuerySingleton.screenSize.width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: i == 0
                            ? Border(
                                top: BorderSide(
                                  color: "#D4D8D6".toColor(),
                                ),
                                bottom: BorderSide(
                                  color: "#D4D8D6".toColor(),
                                ),
                              )
                            : Border(
                                bottom: BorderSide(
                                  color: "#D4D8D6".toColor(),
                                ),
                              ),
                      ),
                      child: GestureDetector(
                        onTap: () => {
                          _onTapSuggestion(
                              lokasiSuggestions[i]['place_id'].toString(),
                              lokasiSuggestions[i]['structured_formatting']
                                  ['main_text'])
                        },
                        child: Text(lokasiSuggestions[i]
                            ['structured_formatting']['main_text']),
                      ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWidgetOnTopOfMap() {
    return Container(
      child: Column(
        children: [
          _buildInputLocation(),
          SizedBox(
            height: 1.h,
          ),
          _buildChooseLocation(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _orderCubit = context.read<OrderCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            // build map here
            _buildMap(),
            // build widget on top map here
            _buildWidgetOnTopOfMap(),
          ],
        ),
      ),
    );
  }
}
