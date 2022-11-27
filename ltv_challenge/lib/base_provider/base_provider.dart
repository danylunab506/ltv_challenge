import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ltv_challenge/constants/api_contants.dart';

class BaseProvider{

  final http.Client _httpClient = http.Client();

  Future<Map<String, dynamic>> get({
    required String service,
    Map<String, dynamic> parameters = const {},
  }) async {

    final Uri uri = Uri.https(ApiConstants.baseUrl, service, parameters);

    late http.Response response;
    try {
      response = await _httpClient.get(uri);
      return json.decode(response.body);
    }  catch (error) {
      return {};
    }
  }

}