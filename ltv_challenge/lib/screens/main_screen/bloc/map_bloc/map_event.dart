part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class AutocompleteEvent extends MapEvent {
  final String text;

  AutocompleteEvent(this.text);
}

class GetDefaultLocationEvent extends MapEvent {
  final BuildContext context;

  GetDefaultLocationEvent(this.context);
}
