import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ltv_challenge/constants/api_contants.dart';

class BaseProvider{

  final http.Client _httpClient = http.Client();

  Future<Map<String, dynamic>> get({
    required String service,
    String baseUrl = ApiConstants.baseUrl,
    Map<String, dynamic> parameters = const {},
  }) async {

    final Uri uri = Uri.https(baseUrl, service, parameters);

    late http.Response response;
    try {
      response = await _httpClient.get(uri);
      return json.decode(response.body);
    }  catch (error) {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getLocationIQAutoComplete({
    Map<String, dynamic> parameters = const {},
  }) async {

    final Uri uri = Uri.https(ApiConstants.baseLocationIQApi, ApiConstants.locationIQAutocompleteService, parameters);
    late http.Response response;
    try {
      response = await _httpClient.get(uri);
      String decodedBody = utf8.decode(response.bodyBytes);
      List<Map<String, dynamic>> mapsList = (jsonDecode(decodedBody) as List<dynamic>).cast<Map<String, dynamic>>();
      
      return mapsList;
    }  catch (error) {
      return [];
    }
  }
}