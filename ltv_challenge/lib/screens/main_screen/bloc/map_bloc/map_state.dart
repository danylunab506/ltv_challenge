part of 'map_bloc.dart';

@immutable
abstract class MapState {
  const MapState();
}

class MapInitial extends MapState {}

class DefaultPositionLoading extends MapState {}

class DefaultPositionLoaded extends MapState {

  final Map<String, double> defaultPosition;

  const DefaultPositionLoaded(
    this.defaultPosition
  );
}

class AutocompleteAddressLoaded extends MapState {

  final AutoCompleteAddressResponseModel autoCompleteAddressResponseModel;

  const AutocompleteAddressLoaded(
    this.autoCompleteAddressResponseModel
  );
}

class Error extends MapState {
  final String? message;

  const Error(
    this.message
  );
}
