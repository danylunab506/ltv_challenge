import 'package:ltv_challenge/base_provider/base_provider.dart';
import 'package:ltv_challenge/constants/api_contants.dart';
import 'package:ltv_challenge/screens/main_screen/models/auto_complete_address_model.dart';

class MapRepository{

  final BaseProvider _baseProvider = BaseProvider();

  Future<AutoCompleteAddressResponseModel> autoCompleteAddress({
    required String text
  }) async {
    final List<Map<String, dynamic>> response = await _baseProvider.getLocationIQAutoComplete(
      parameters: {
        'key': ApiConstants.locationIQToken,
        'q': text
      },
    );
    var myListIter = response.iterator;
    List<Map<String, dynamic>> placesList = [];
    while(myListIter.moveNext()){
        placesList.add(myListIter.current);
    }

    AutoCompleteAddressResponseModel autoCompleteAddressResponseModel = AutoCompleteAddressResponseModel.fromList(placesList);
    return autoCompleteAddressResponseModel;
  }
}

class NetworkError extends Error {}