import 'package:bot_toast/bot_toast.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:mealorder/app/app_config.dart';
import 'package:mealorder/ui/shared/utils.dart';

class LocationService {
  Location location = Location();

  Future<LocationData?> getUserCurrentLocation({bool hideLoader = true}) async {
    LocationData locationData;

    if (!await isLocationEnabeld()) return null;

    if (!await isPermissionGranted()) return null;

    customLoader();

    locationData = await location.getLocation();

    if (hideLoader) BotToast.closeAllLoading();

    return locationData;
  }

  Future<geo.Placemark?> getAddressInfo(LocationData locationData,
      {bool showLoader = true}) async {
    if (showLoader) customLoader();

    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);

    BotToast.closeAllLoading();

    if (placemarks.isNotEmpty) {
      return placemarks[0];
    } else {
      return null;
    }
  }

  Future<geo.Placemark?> getCurrentAddressInfo() async {
    return await getAddressInfo(
        await getUserCurrentLocation(hideLoader: false) ??
            LocationData.fromMap({}),
        showLoader: false);
  }

  Future<bool> isLocationEnabeld() async {
    bool _serviceEnabled;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        if (AppConfig.isLocationRequired) {
          //!-- Message to show --
        }
        return false;
      }
    }
    return _serviceEnabled;
  }

  Future<bool> isPermissionGranted() async {
    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        //!-- Message to show --
        return false;
      }
    }
    return _permissionGranted == PermissionStatus.granted;
  }
}
