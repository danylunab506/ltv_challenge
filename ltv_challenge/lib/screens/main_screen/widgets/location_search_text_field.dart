import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ltv_challenge/screens/main_screen/bloc/map_bloc/map_repository.dart';
import 'package:ltv_challenge/screens/main_screen/models/auto_complete_address_model.dart';

class LocationSearchTextField extends StatefulWidget {

  final Function updateMarkers;

  const LocationSearchTextField({
    super.key,
    required this.updateMarkers
  });

  @override
  State<LocationSearchTextField> createState() => _LocationSearchTextFieldState();
}

class _LocationSearchTextFieldState extends State<LocationSearchTextField> {

  String locationToBeSearched = '';
  TextEditingController textFieldController = TextEditingController();
  late Timer timer;
  final MapRepository mapRepository = MapRepository();

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), (){});
    textFieldController.addListener(textFieldEvent);
  }

  @override
  void dispose() {
    textFieldController.dispose();
    timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: double.infinity,
      height: 50.0,
      child: TextField(
        controller: textFieldController,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Search address',
          fillColor: Colors.white,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  void textFieldEvent() {
    final String text = textFieldController.text;
    locationToBeSearched = text;
    timer.cancel();
    timer = Timer(const Duration(seconds: 1), callAutoCompleteAPI);
  }

  Future<void> callAutoCompleteAPI() async {
    if (locationToBeSearched.isNotEmpty) {
      final AutoCompleteAddressResponseModel autoCompleteAddressResponse = await mapRepository.autoCompleteAddress(
        text: locationToBeSearched
      );
      widget.updateMarkers(
        places: autoCompleteAddressResponse.places
      );
    }
  }
}