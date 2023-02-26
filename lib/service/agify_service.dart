import 'dart:convert';
import 'dart:async';
import 'package:age_guesser/service/agify_result.dart';
import 'package:http/http.dart' as http;

class AgifyApiService {
  Future<AgifyResult> getAgeForName(String name) {
    var httpClient = http.Client();
    var url = _getRequestURLForName(name);
    return httpClient.get(url).then((response) {
      var json = jsonDecode(response.body);
      return AgifyResult.fromJSON(json);
    });
  }

  Uri _getRequestURLForName(String name) {
    return Uri(
        scheme: 'https',
        host: 'api.agify.io',
        path: '/',
        queryParameters: {'name': name, 'country_id': 'DE'});
  }
}
