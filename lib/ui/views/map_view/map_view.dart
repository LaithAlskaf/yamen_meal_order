import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mealorder/core/enums/request_status.dart';
import 'package:mealorder/ui/views/map_view/map_controller.dart';

class MapView extends StatefulWidget {
  final LocationData currentLocation;
  const MapView({super.key, required this.currentLocation});

  @override
  State<MapView> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MapController(widget.currentLocation),
        builder: (mapController) {
          return Scaffold(
            body: GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: mapController.currentPosition,
              onMapCreated: (GoogleMapController controller) async {
                mapController.controller.complete(controller);

                mapController.countryList.forEach((element) {
                  mapController.addMarker(
                      position: LatLng(element.latitude ?? 37.42796133580664,
                          element.longitude ?? -122.085749655962),
                      id: element.alpha2.toString());
                });
              },
              markers: mapController.markers,
              onTap: (latlong) {
                mapController.selecteLocation = latlong;

                mapController.addMarker(
                    imageUrl: 'https://www.fluttercampus.com/img/car.png',
                    position: LatLng(latlong.latitude, latlong.longitude),
                    id: 'current');
              },
            ),
            floatingActionButton:
            mapController.requestStatus == RequestStatus.LOADING
                ? CircularProgressIndicator()
                : FloatingActionButton.extended(
              onPressed: _goToTheLake,
              label: Text(mapController.streetName.value),
              icon: const Icon(Icons.directions_boat),
            ),
          );
        });
  }

  Future<void> _goToTheLake() async {
    // final GoogleMapController controller = await _controller.future;
    // await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}