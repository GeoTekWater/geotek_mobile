// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/screens/sub_screen/borehole/borehold_info_screen.dart';
import 'package:geo_tek/widgets/buttons/custom_button.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/data/index.dart';
import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';
import 'package:geo_tek/models/borehole_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  CustomInfoWindowController customInfoWindowcontroller =
      CustomInfoWindowController();
  final Set<Marker> markers = {};

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    final ByteData _data = await rootBundle.load(path);
    final ui.Codec _codec = await ui
        .instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo _fi = await _codec.getNextFrame();
    final Uint8List _bytes =
        (await _fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
    return _bytes;
  }

  Future<void> onMapCreated() async {
    final Uint8List markerIcon = await getBytesFromAsset(
        path: 'assets/icons/icon__marker.png', width: 40);

    setState(() {
      markers.clear();
      for (final BoreHoleModel boreHole in appBoreholes) {
        markers.add(
          Marker(
            icon: BitmapDescriptor.fromBytes(markerIcon),
            markerId: MarkerId('${boreHole.name}'),
            position: LatLng(
                boreHole.latitude!.toDouble(), boreHole.longitude!.toDouble()),
            onTap: () {
              customInfoWindowcontroller.addInfoWindow!(
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  // height: 25.0.hp,
                  decoration: BoxDecoration(
                    color: AppStyles.bgWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: 18.0.hp,
                        height: MediaQuery.of(context).size.height * 0.18,
                        // width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: AssetImage('${boreHole.image}'),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                      Container(
                        // color: AppStyles.bgBlack,
                        // height: 15.0.hp,
                        height: MediaQuery.of(context).size.height * 0.12,
                        padding: EdgeInsets.only(
                          top: 1.0.hp,
                          left: 2.0.wp,
                          right: 2.0.wp,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomTextWidget(
                                  maxLines: 1,
                                  text: 'Location: ',
                                  size: constructFontSize(context, 16),
                                ),
                                Expanded(
                                  child: CustomTextWidget(
                                    maxLines: 5,
                                    text: '${boreHole.address}',
                                    size: constructFontSize(context, 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.0.hp),
                            Center(
                              child: CustomButton(
                                text: 'More',
                                width: 40.0.wp,
                                // width: 20.0.hp,
                                height: 4.0.hp,
                                onTapHandler: () {
                                  Get.to(() =>
                                      BoreholeInfoScreen(boreHole: boreHole));
                                },
                                fontSize: constructFontSize(context, 14),
                                // fontSize: 12.0.sp,
                                borderRadius: 40,
                                fontColor: Colors.white,
                                fontWeight: FontWeight.bold,
                                backgroundColor: AppStyles.bgPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                LatLng(boreHole.latitude!.toDouble(),
                    boreHole.longitude!.toDouble()),
              );
            },
          ),
        );
      }
    });
  }

  void initializeMapFunctions() async {
    await onMapCreated();
  }

  @override
  void initState() {
    super.initState();

    initializeMapFunctions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Google Office Locations'),
      //   elevation: 2,
      // ),
      body: Stack(
        children: [
          GoogleMap(
            scrollGesturesEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              customInfoWindowcontroller.googleMapController = controller;

              // changeMapMode(controller);
              // onMapcreated();
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(9.906587499999999, 8.9547031),
              // zoom: 10,
              zoom: 12,
            ),
            markers: markers,
            onTap: (Position) {
              customInfoWindowcontroller.hideInfoWindow!();
            },
            onCameraMove: (Position) {
              customInfoWindowcontroller.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowcontroller,
            // height: 28.0.hp,
            height: MediaQuery.of(context).size.height * 0.3,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
