import 'package:http/http.dart' as http;

class NetworkHandler {
  static final client = http.Client();

  static Future<http.Response> postRequest(var body) async {
    var response = await client.post(buildUrl(), body: body, headers: {
      "Content-Type": "application/json",
    });

    return response;
  }

  // static Future<http.Response> logout(String endpoint, token) async {
  //   var response = await client.get(buildUrl(endpoint),
  //       headers: {"Content-Type": "application/json", "Authorization": token});
  //   return response;
  // }

  static Uri buildUrl() {
    String host = "https://app.smartsmssolutions.com/io/api/client/v1/sms/";
    return Uri.parse(host);
  }
}
