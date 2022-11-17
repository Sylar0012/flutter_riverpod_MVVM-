import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final httpConnector = Provider<HttpConnector>((ref) {
  return HttpConnector();
});

class HttpConnector {
  final host = "http://localhost:5000";
  final Client _client = Client();

  Future<Response> get(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    // cpu 가 데이터 다운이 되었는지 안되었는지 계속 while을 돌며 기다림 .
    Response response = await _client.get(uri);
    return response;
  }
}
