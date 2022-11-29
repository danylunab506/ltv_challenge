import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ltv_challenge/constants/api_contants.dart';
import 'package:ltv_challenge/screens/main_screen/bloc/map_bloc/map_bloc.dart';
import 'package:ltv_challenge/screens/main_screen/models/auto_complete_address_model.dart';
import 'package:ltv_challenge/utils/utils.dart';
import 'location_search_text_field.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  final MapBloc _mapBloc = MapBloc();
  Set<Marker> _markers = Set();
  GoogleMapController? mapController;
  final double _zoom = 11.0;
  final int _maxMarkersToShow = 5;

  @override
  void initState() {
    super.initState();
    _mapBloc.add(GetDefaultLocationEvent(context));
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => _mapBloc,
      child: BlocListener<MapBloc, MapState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapInitial || state is DefaultPositionLoading) {
              return const Center(child: CircularProgressIndicator());

            } else if (state is DefaultPositionLoaded) {
              return _generateMap(state.defaultPosition);
              
            } else if (state is Error) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _generateMap(Map<String, double> defaultPosition){
    double lat = defaultPosition['lat'] ?? ApiConstants.deaultPositionLat;
    double lon = defaultPosition['lon'] ?? ApiConstants.deaultPositionLong;

    LatLng kMapCenter = LatLng(lat, lon);
    CameraPosition kInitialPosition = CameraPosition(target: kMapCenter, zoom: _zoom, tilt: 0, bearing: 0);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: kInitialPosition,
          myLocationEnabled: true,
          markers: _markers,
          gestureRecognizers: Set()
            ..add(
              Factory<PanGestureRecognizer>(
                () => PanGestureRecognizer()
              )
            ),
          onMapCreated: (controller) {
            mapController = controller;
          },
        ),
        LocationSearchTextField(
          updateMarkers: _updateMarkers,
        ),
      ],
    );
  }

  void _updateMarkers({
    required List<PlaceResultModel> places
  }){
    _markers.clear();
    if(places.isEmpty){
      showAlert(
        context: context, 
        message: "No records found. Please type a new address"
      );
      return;
    }

    for (var i = 0; i < _maxMarkersToShow && i < places.length; i++) {
      PlaceResultModel place = places[i];
      Marker placeMarker = Marker(
        markerId: MarkerId(place.osmId.toString()),
        infoWindow: InfoWindow(
          title: place.displayPlace,
          snippet: place.displayAddress
        ),
        position: LatLng(checkDouble(place.lat), checkDouble(place.lon)),
      );
      _markers.add(placeMarker);
    }

    if(places.isNotEmpty){
      LatLng newlatlang =  LatLng(checkDouble(places[0].lat), checkDouble(places[0].lon));
      mapController?.animateCamera( 
        CameraUpdate.newCameraPosition(
          CameraPosition(target: newlatlang, zoom: _zoom)
        )
      );
    }
    setState(() {});
  }

}