import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mealorder/core/data/models/api/country_model.dart';
import 'package:mealorder/core/services/base_controller.dart';
import 'package:mealorder/core/utils/map_util.dart';
import 'package:mealorder/ui/shared/utils.dart';

class MapController extends BaseController {
  MapController(this.currentLocation);

  late LocationData currentLocation;
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  late CameraPosition currentPosition;
  RxSet<Marker> markers = <Marker>{}.obs;
  late LatLng selecteLocation;
  RxString streetName = ''.obs;
  late CameraPosition initalCameraPosition;
  late LatLng selectedLocation;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List<CountryModel> countryList = [];

  @override
  void onInit() {
    initalCameraPosition = CameraPosition(
      target: LatLng(currentLocation.latitude ?? 37.43296265331129,
          currentLocation.longitude ?? -122.08832357078792),
      zoom: 14.4746,
    );

    selectedLocation = LatLng(currentLocation.latitude ?? 37.43296265331129,
        currentLocation.longitude ?? -122.08832357078792);
    locationService.getUserCurrentLocation(hideLoader: true);
    currentPosition = CameraPosition(
      target: LatLng(currentLocation.latitude ?? 37.42796133580664,
          currentLocation.longitude ?? -122.085749655962),
      zoom: 4,
    );
    selecteLocation = LatLng(currentLocation.latitude ?? 37.42796133580664,
        currentLocation.longitude ?? -122.08574965596);

    super.onInit();
  }

  void addMarker({
    required LatLng position,
    required String id,
    String? imageName,
    String? imageUrl,
  }) async {
    BitmapDescriptor markerIcon = imageName != null
        ? await MapUtil.getImageFromAsset(imageName: imageName)
        : imageUrl != null
            ? await MapUtil.getImageFromNetwork(imageUrl: imageUrl)
            : BitmapDescriptor.defaultMarker;

    markers.add(
        Marker(markerId: MarkerId(id), position: position, icon: markerIcon));
    // getStreetName();
    update();
  }

  void getStreetName() async {
    runLoadingFutureFunction(
        function: locationService
            .getAddressInfo(
                showLoader: false,
                LocationData.fromMap({
                  'latitude': selecteLocation.latitude,
                  'longitude': selecteLocation.longitude
                }))
            .then((value) {
      streetName.value = value?.street ?? 'No Info Found';
      update();
    }));
  }
}
