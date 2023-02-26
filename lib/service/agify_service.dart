import 'dart:convert';
import 'dart:async';
import 'package:age_guesser/service/agify_result.dart';
import 'package:http/http.dart' as http;

enum AgifyApiError { tooManyRequests, nameNotInDatabase, unknownError }

class AgifyApiService {
  Future<AgifyResult> getAgeForName(String name) {
    var httpClient = http.Client();
    var url = _getRequestURLForName(name);
    return httpClient.get(url).then((response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        try {
          var age = _mapResponse(json);
          return AgifyResult(age, name);
        } catch (error) {
          rethrow;
        }
      }

      if (response.statusCode == 429) {
        throw Exception(AgifyApiError.tooManyRequests);
      }

      throw Exception(AgifyApiError.unknownError);
    });
  }

  int _mapResponse(dynamic jsonResponse) {
    if (jsonResponse == null) {
      throw Exception(AgifyApiError.unknownError);
    }

    if (jsonResponse['count'] != null) {
      throw Exception(AgifyApiError.unknownError);
    }

    if (jsonResponse['count'] == 0) {
      throw Exception(AgifyApiError.nameNotInDatabase);
    }

    if (jsonResponse['age'] == null) {
      throw Exception(AgifyApiError.unknownError);
    }

    return jsonResponse['age'];
  }

  Uri _getRequestURLForName(String name) {
    return Uri(
        scheme: 'https',
        host: 'api.agify.io',
        path: '/',
        queryParameters: {'name': name, 'country_id': 'DE'});
  }
}
