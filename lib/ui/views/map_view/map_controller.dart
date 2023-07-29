// import 'dart:async';
//
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mealorder/core/services/location_services/location_services.dart';
// import 'package:mealorder/ui/shared/utils.dart';
//
// class MapController extends GetxController{
//   late CameraPosition initalCameraPosition;
//
//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   final Completer<GoogleMapController> _controller =
//   Completer<GoogleMapController>();
//   final LocationDar
//
//   @override
//   void initState() {
//     locationService.getUserCurrentLocation(hideLoader: true);
//     initalCameraPosition = CameraPosition(
//       target: LatLng(widget.currentLocation.latitude ?? 37.43296265331129,
//           widget.currentLocation.longitude ?? -122.08832357078792),
//       zoom: 14.4746,
//     );
//
//     selectedLocation = LatLng(
//         widget.currentLocation.latitude ?? 37.43296265331129,
//         widget.currentLocation.longitude ?? -122.08832357078792);
//     super.initState();
//   }
//
//   Set<Marker> markers = {};
//
//   late LatLng selectedLocation;
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//   }
//
// }