import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final httpConnector = Provider<HttpConnector>((ref) {
  return HttpConnector();
});

class HttpConnector {
  final host = "http://localhost:5000";
  final Client _client = Client();
  final headers = {"Content-Type": "application/json; charset=utf-8"};

  Future<Response> get(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    // cpu 가 데이터 다운이 되었는지 안되었는지 계속 while을 돌며 기다림 .
    Response response = await _client.get(uri);
    return response;
  }

  Future<Response> post(String path, String body) async {
    Uri uri = Uri.parse("${host}${path}");
    print("post : " + body.toString());
    Response response = await _client.post(uri, body: body, headers: headers);
    print("post response : " + response.body.toString());
    return response;
  }

  Future<Response> delete(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    // cpu 가 데이터 다운이 되었는지 안되었는지 계속 while을 돌며 기다림 .
    Response response = await _client.delete(uri);
    return response;
  }

  Future<Response> put(String path, String body) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.put(uri, body: body, headers: headers);
    return response;
  }
}
