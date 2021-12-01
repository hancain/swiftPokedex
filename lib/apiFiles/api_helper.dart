import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class ApiBaseHelper {
  final String _mainURL = "https://pokeapi.co/api/v2/";

  Future<dynamic> get(String url) async {
    dynamic responseObj;
    try {
      final response = await http.get(Uri.parse(_mainURL + url));
      responseObj = _returnResponse(response);
    }
    on SocketException {
      throw Exception('No connection');
    }
    return responseObj;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }
}