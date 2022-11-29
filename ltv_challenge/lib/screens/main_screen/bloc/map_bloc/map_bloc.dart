import 'package:bloc/bloc.dart';
import 'package:ltv_challenge/screens/main_screen/bloc/map_bloc/map_repository.dart';
import 'package:ltv_challenge/screens/main_screen/models/auto_complete_address_model.dart';
import 'package:ltv_challenge/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  
  MapBloc() : super(MapInitial()) {
    final MapRepository mapRepository = MapRepository();

    on<AutocompleteEvent>((event, emit) async {
      try {
        final AutoCompleteAddressResponseModel autoCompleteAddressRespons = await mapRepository.autoCompleteAddress(
          text: event.text
        );
        emit(AutocompleteAddressLoaded(autoCompleteAddressRespons));
      } on NetworkError {
        emit(const Error("Failed to fetch data. is your device online?"));
      }
    });

    on<GetDefaultLocationEvent>((event, emit) async {
      try {
        emit(DefaultPositionLoading());
        final Map<String, double> locationPermissionAllowed = await getDeviceLocation(
          context: event.context
        );
        emit(DefaultPositionLoaded(locationPermissionAllowed));
      } on NetworkError {
        emit(const Error("Failed to fetch data. is your device online?"));
      }
    });
  }
}
