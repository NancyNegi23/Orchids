import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(msg: 'Please keep your location on');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: 'Location Permission is denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(msg: 'Location Permission is denied forever');
  }

  return await Geolocator.getCurrentPosition();
}

// Future<Position?> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     EasyLoading.showError('locations_services_disabled');

//     return null;
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       EasyLoading.showError('locations_permissions_denied');

//       return null;
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     EasyLoading.showError('locations_permissions_permanently_denied');

//     return null;
//   }

//   return await Geolocator.getCurrentPosition();
// }
