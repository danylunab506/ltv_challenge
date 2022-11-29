import 'package:flutter/material.dart';
import 'package:ltv_challenge/constants/api_contants.dart';
import 'package:geolocator/geolocator.dart';

String checkString(dynamic value) => value == null ? "" : value.toString();

double checkDouble(dynamic value) {
  if (value == null) {
    return 0.0;
  } else if (value is String) {
    return double.tryParse(value)!.toDouble();
  } else if (value is int) {
    return 0.0 + value;
  } else {
    return value;
  }
}

List<dynamic> checkList(dynamic value) {
  if (value != null && value is List) {
    return value;
  }

  return [];
}

void showAlert({
  required BuildContext context,
  required String message
}){
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return  AlertDialog(  
        title: const Text(
          'Warning',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold
          ),
        ),  
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal
          ),
        ),  
        actions: [  
          TextButton(
            onPressed: () { 
              Navigator.of(context).pop(); 
            },
            child: const Text(
              "OK",
              style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal
            ),
            ), 
          )
        ],  
      ); 
    },  
  ); 
}

String generateCorrectUrlForImages({
  required String? imageUrl
}){
  List<String> splitUrl = imageUrl!.split('/');
  for (String element in splitUrl) {
    if(element.contains('.png') || element.contains('.jpg')){
      return  '${ApiConstants.baseUrlForImages}$element';
    }
  }
  return '';
}

Future<Map<String, double>> getDeviceLocation({
  required BuildContext context
}) async {
    bool serviceEnabled;
    LocationPermission permission;
    bool accessDeviceLocationAllowed = true;
    Map<String, double> defaultPosition = {
      'lat': ApiConstants.deaultPositionLat,
      'lon': ApiConstants.deaultPositionLong
    };
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlert(
        context: context,
        message: 'Location services are disabled. Please enable the services'
      );
      accessDeviceLocationAllowed = false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {  
        showAlert(
          context: context,
          message: 'Location permissions are denied'
        ); 
        accessDeviceLocationAllowed = false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlert(
          context: context,
          message: 'Location permissions are permanently denied, we cannot request permissions.'
        );
      accessDeviceLocationAllowed = false;
    }

    if(accessDeviceLocationAllowed){
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position != null ? {
        'lat': position.latitude,
        'lon': position.longitude
      } : defaultPosition;
    }

    return defaultPosition;
  }