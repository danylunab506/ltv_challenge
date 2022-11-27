import 'package:flutter/material.dart';
import 'package:ltv_challenge/constants/api_contants.dart';

String checkString(dynamic value) => value == null ? "" : value.toString();

List<dynamic> checkList(dynamic value) {
  if (value != null && value is List) {
    return value;
  }

  return [];
}

void showAlert({
  required BuildContext context,
  required String message
}){
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return  AlertDialog(  
        title: const Text(
          'Warning',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold
          ),
        ),  
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal
          ),
        ),  
        actions: [  
          TextButton(
            onPressed: () { 
              Navigator.of(context).pop(); 
            },
            child: const Text(
              "OK",
              style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal
            ),
            ), 
          )
        ],  
      ); 
    },  
  ); 
}

String generateCorrectUrlForImages({
  required String? imageUrl
}){
  List<String> splitUrl = imageUrl!.split('/');
  for (String element in splitUrl) {
    if(element.contains('.png') || element.contains('.jpg')){
      return  '${ApiConstants.baseUrlForImages}$element';
    }
  }
  return '';
}