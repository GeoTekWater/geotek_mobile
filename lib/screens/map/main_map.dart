// // ignore_for_file: prefer_const_constructors
// import 'dart:async';
// import 'dart:developer';
// import 'dart:ui' as ui;
// import 'dart:convert';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:geo_tek/screens/sub_screen/borehole/borehold_info_screen.dart';
// import 'package:geo_tek/widgets/buttons/custom_button.dart';
// import 'package:geo_tek/config/app_config.dart';
// import 'package:geo_tek/data/index.dart';
// import 'package:geo_tek/widgets/text/custom_text_widget.dart';
// import 'package:get/get.dart';
// import 'package:geo_tek/models/borehole_model.dart';

// // import 'package:location/location.dart' as GeoLocation;

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MainMap extends StatefulWidget {
//   const MainMap({super.key});

//   @override
//   State<MainMap> createState() => _MainMapState();
// }

// class _MainMapState extends State<MainMap> {
//   CustomInfoWindowController customInfoWindowcontroller =
//       CustomInfoWindowController();
//   final Set<Marker> markers = {};
//   Position? currentLocation;
//   GoogleMapController? googleMapController;
//   // late bool _serviceEnabled;
//   // late GeoLocation.PermissionStatus _permissionGranted;

//   RxBool isLocationPermissionActive = false.obs;
//   LatLng latLng = const LatLng(9.922084666154559, 8.890605481537557);
//   final Completer<GoogleMapController> _controller = Completer();

//   Future<Uint8List> getBytesFromAsset(
//       {required String path, required int width}) async {
//     final ByteData _data = await rootBundle.load(path);
//     final ui.Codec _codec = await ui
//         .instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: width);
//     final ui.FrameInfo _fi = await _codec.getNextFrame();
//     final Uint8List _bytes =
//         (await _fi.image.toByteData(format: ui.ImageByteFormat.png))!
//             .buffer
//             .asUint8List();
//     return _bytes;
//   }

//   void initializeMapFunctions() async {
//     await Future.delayed(const Duration(milliseconds: 3500));

//     await initializeCurrentLocation();

//     await onMapcreated();
//   }

//   Future<void> initializeCurrentLocation() async {
//     if (mounted) {
//       LocationPermission locationPermission =
//           await Geolocator.checkPermission();

//       log('[LOCATION-PERMISSION] :: $locationPermission');

//       if (locationPermission == LocationPermission.denied ||
//           locationPermission == LocationPermission.deniedForever ||
//           locationPermission == LocationPermission.unableToDetermine) {
//         isLocationPermissionActive.value = false;
//       } else {
//         log('[LOCATION-PERMISSION] :: $locationPermission');

//         isLocationPermissionActive.value = true;

//         currentLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );

//         setState(() {
//           latLng =
//               LatLng(currentLocation!.latitude, currentLocation!.longitude);
//         });

//         log('[CURRENT-LOCATION] :: $currentLocation');

//         googleMapController = await _controller.future;

//         googleMapController?.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               zoom: 13,
//               target: latLng,
//             ),
//           ),
//         );
//       }
//     }
//   }

//   Future onMapcreated() async {
//     if (mounted) {
//       final Uint8List myMarkerIcon = await getBytesFromAsset(
//           path: 'assets/icons/icon__marker__3.png', width: 60);

//       googleMapController = await _controller.future;

//       setState(() {
//         markers.add(Marker(
//           icon: BitmapDescriptor.fromBytes(myMarkerIcon),
//           markerId: MarkerId('122'),
//           position: currentLocation != null ? latLng : latLng,
//         ));
//       });

//       googleMapController?.animateCamera(
//         CameraUpdate.newLatLng(latLng),
//       );
//     }
//   }

//   @override
//   void initState() {
//     initializeMapFunctions();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Google Office Locations'),
//       //   elevation: 2,
//       // ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             scrollGesturesEnabled: true,
//             compassEnabled: true,
//             myLocationEnabled: true,
//             zoomControlsEnabled: false,
//             myLocationButtonEnabled: false,
//             mapToolbarEnabled: false,
//             mapType: MapType.normal,
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);

//               customInfoWindowcontroller.googleMapController = controller;

//               // changeMapMode(controller);
//               // onMapcreated();
//             },
//             initialCameraPosition: CameraPosition(
//               target: currentLocation != null
//                   ? LatLng(
//                       currentLocation!.latitude, currentLocation!.longitude)
//                   : latLng,
//               // zoom: 10,
//               zoom: 14,
//             ),
//             markers: markers,
//             onTap: (Position) {
//               customInfoWindowcontroller.hideInfoWindow!();
//             },
//             onCameraMove: (Position) {
//               customInfoWindowcontroller.onCameraMove!();
//             },
//           ),
//           CustomInfoWindow(
//             controller: customInfoWindowcontroller,
//             // height: 28.0.hp,
//             height: MediaQuery.of(context).size.height * 0.35,
//             width: 300,
//             offset: 35,
//           ),
//         ],
//       ),
//     );
//   }
// }


// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/data/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:geo_tek/widgets/text/custom_text_widget.dart';
import 'package:get/get.dart';

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  CustomInfoWindowController customInfoWindowcontroller =
      CustomInfoWindowController();

  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = {};

  RxBool isLocationPermissionActive = false.obs;

  LocationData? currentLocation;
  GoogleMapController? googleMapController;

  LatLng fallbackLatLng = const LatLng(9.922084666154559, 8.890605481537557);
  LatLng currentLatLng = const LatLng(9.922084666154559, 8.890605481537557);

  Location location = Location();

  Future<Uint8List> getBytesFromAsset({
    required String path,
    required int width,
  }) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> initializeMapFunctions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await initializeCurrentLocation();
    await addInitialMarker();
  }

  Future<void> initializeCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        log("[LOCATION] Service not enabled.");
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied ||
        permissionGranted == PermissionStatus.deniedForever) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        log("[LOCATION] Permission denied.");
        return;
      }
    }

    currentLocation = await location.getLocation();

    if (currentLocation != null) {
      currentLatLng = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      isLocationPermissionActive.value = true;

      googleMapController = await _controller.future;
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13,
            target: currentLatLng,
          ),
        ),
      );
    }
  }

  Future<void> addInitialBoreholeMarkers() async {
    for (var borehole in boreholes) {
      final Uint8List markerIcon =
          await getBytesFromAsset(path: 'assets/icons/icon__marker__3.png', width: 60);
    }
  }

  Future<void> addInitialMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset(path: 'assets/icons/icon__marker__3.png', width: 60);

    markers.add(Marker(
      markerId: MarkerId('current'),
      icon: BitmapDescriptor.fromBytes(markerIcon),
      position: currentLatLng,
    ));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializeMapFunctions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentLatLng,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              customInfoWindowcontroller.googleMapController = controller;
            },
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            scrollGesturesEnabled: true,
            compassEnabled: true,
            markers: markers,
            onTap: (position) {
              customInfoWindowcontroller.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowcontroller.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowcontroller,
            height: MediaQuery.of(context).size.height * 0.35,
            width: 300,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
