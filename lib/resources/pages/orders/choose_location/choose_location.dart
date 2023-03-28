import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mangjek_app/app/constants/choose_location.dart';
import 'package:mangjek_app/app/controllers/controller.dart';
import 'package:mangjek_app/app/extensions/string.dart';
import 'package:mangjek_app/app/singleton/media_query.dart';
import 'package:mangjek_app/resources/widgets/input_location_widget.dart';
import 'package:mangjek_app/resources/widgets/pile_button_widget.dart';
import 'package:mangjek_app/routes/constant.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:sizer/sizer.dart';

class ChooseLocation extends NyStatefulWidget {
  ChooseLocation({super.key});

  final Controller controller = Controller();

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

LatLng initCameraLocation = LatLng(-3.2189977434045636, 104.65166153632049);

class _ChooseLocationState extends NyState<ChooseLocation> {
  late ChooseLocationType prevClickOnType;

  @override
  init() {
    prevClickOnType = widget.data() as ChooseLocationType;
    return super.init();
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
                  onTapJemput: () {},
                  onTapTujuan: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<String> suggestedLocaton = [
    "Fasilkom, Indralaya",
    "FKIP, Indralaya",
    "FKIP, Indralaya",
    "FKIP, Indralaya",
    "FKIP, Indralaya",
  ];

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
                  routeTo(ROUTE_ORDERS_CHOOSE_FROM_MAP_PAGE, data: true);
                },
              ),
              PileButtonWidget(
                iconLocation: "maps.png",
                label: "Pilih dari maps",
                onTap: () {
                  routeTo(ROUTE_ORDERS_CHOOSE_FROM_MAP_PAGE, data: false);
                },
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
                for (var i = 0; i < suggestedLocaton.length; i++)
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
                    child: Text(suggestedLocaton[i]),
                  )
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              // build map here
              _buildMap(),
              // build widget on top map here
              _buildWidgetOnTopOfMap(),
            ],
          ),
        ),
      ),
    );
  }
}
