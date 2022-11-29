import 'package:ltv_challenge/utils/utils.dart';

// List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

// String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AutoCompleteAddressResponseModel {

  List<PlaceResultModel>? places;

  AutoCompleteAddressResponseModel({
    this.places,
  });

  AutoCompleteAddressResponseModel.fromList(List<Map<String, dynamic>> list) {
    places = [];
    for (Map<String, dynamic> place in list) {
      PlaceResultModel placeResultModel = PlaceResultModel.fromJson(place);
      places!.add(placeResultModel);
    }
  }

  Map<String, dynamic> toJson() => {
    "places": List<PlaceResultModel>.from(places!.map((x) => x.toJson())),
  };
}

class PlaceResultModel {
  
  String? placeId;
  String? osmId;
  String? osmType;
  String? licence;
  String? lat;
  String? lon;
  List<String>? boundingbox;
  String? welcomeClass;
  String? type;
  String? displayName;
  String? displayPlace;
  String? displayAddress;
  Address? address;

  PlaceResultModel({
    this.placeId,
    this.osmId,
    this.osmType,
    this.licence,
    this.lat,
    this.lon,
    this.boundingbox,
    this.welcomeClass,
    this.type,
    this.displayName,
    this.displayPlace,
    this.displayAddress,
    this.address,
  });

  factory PlaceResultModel.fromJson(Map<String, dynamic> json) => PlaceResultModel(
    placeId: checkString(json["place_id"]),
    osmId: checkString(json["osm_id"]),
    osmType: checkString(json["osm_type"]),
    licence: checkString(json["licence"]),
    lat: checkString(json["lat"]),
    lon: checkString(json["lon"]),
    boundingbox: List<String>.from(checkList(json["boundingbox"]).map((x) => x)),
    welcomeClass: checkString(json["class"]),
    type: checkString(json["type"]),
    displayName: checkString(json["display_name"]),
    displayPlace: checkString(json["display_place"]),
    displayAddress: checkString(json["display_address"]),
    address: Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "place_id": placeId,
    "osm_id": osmId,
    "osm_type": osmType,
    "licence": licence,
    "lat": lat,
    "lon": lon,
    "boundingbox": List<dynamic>.from(boundingbox!.map((x) => x)),
    "class": welcomeClass,
    "type": type,
    "display_name": displayName,
    "display_place": displayPlace,
    "display_address": displayAddress,
    "address": address!.toJson(),
  };
}

class Address {

  String? name;
  String? city;
  String? county;
  String? state;
  String? postcode;
  String? country;
  String? countryCode;

  Address({
    this.name,
    this.city,
    this.county,
    this.state,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    name: checkString(json["name"]),
    city: checkString(json["city"]),
    county: checkString(json["county"]),
    state: checkString(json["state"]),
    postcode: checkString(json["postcode"]),
    country: checkString(json["country"]),
    countryCode: checkString(json["country_code"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "city": city,
    "county": county,
    "state": state,
    "postcode": postcode,
    "country": country,
    "country_code": countryCode,
  };
}
