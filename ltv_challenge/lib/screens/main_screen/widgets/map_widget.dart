import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ltv_challenge/constants/api_contants.dart';
import 'package:ltv_challenge/utils/utils.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  Completer<GoogleMapController> mapController = Completer();
  bool locationLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, double>> _getDeviceLocation() async {
    var locationPermissionAllowed = await getDeviceLocation(
      context: context
    );
    locationLoaded = true;
    return locationPermissionAllowed;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String, double>>(
      future: _getDeviceLocation(),
      initialData: const {
        'lat': ApiConstants.deaultPositionLat,
        'lon': ApiConstants.deaultPositionLong
      },
      builder: (BuildContext context, AsyncSnapshot<Map<String, double>> snapshot) {
        if(snapshot.hasData && locationLoaded){
          double? lat = snapshot.data?['lat'];
          double? lon = snapshot.data?['lon'];

          LatLng kMapCenter = LatLng(lat!.toDouble(), lon!.toDouble());
          CameraPosition kInitialPosition = CameraPosition(target: kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

          return GoogleMap(
            initialCameraPosition: kInitialPosition,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
            },
            gestureRecognizers: Set()
              ..add(
                Factory<PanGestureRecognizer>(
                  () => PanGestureRecognizer()
                )
              )
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}