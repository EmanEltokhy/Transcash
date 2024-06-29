import 'dart:convert';

import 'package:http/http.dart' as http;

const baseURL = 'transcash.internship2023.et3.co';
const UtilitiesBaseURL = 'transcash-utilities.internship2023.et3.co';
// const baseURL = '192.168.1.4';

Future<dynamic> httpRequest(
    {bool? visa, token, mobile, data, path, queryParams}) {
  final url = Uri.https("$baseURL", path, queryParams);

  return http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(data),
  );
}

Future<dynamic> getRequest({token, path, queryParams}) {
  final url = Uri.https("$baseURL", path, queryParams);
  return http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
}

Future<dynamic> homeRequest({token, path, data}) {
  final url = Uri.https("$baseURL", path);
  return http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );
}

Future<dynamic> getAmount({path, queryParams}) {
  final url = Uri.https("$UtilitiesBaseURL", path, queryParams);
  return http.get(
    url,
  );
}

Future<dynamic> deleteAmount({path}) {
  final url = Uri.https("$UtilitiesBaseURL", path);
  return http.delete(
    url,
  );
}
