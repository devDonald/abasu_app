import 'package:abasu_app/core/constants/contants.dart';
import 'package:http/http.dart' as http;

class SMSClass {
  Future<void> sendSMS(String to, String message) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://app.smartsmssolutions.com/io/api/client/v1/sms/'));
    request.fields.addAll({
      'token': smsToken,
      'sender': "Abasu Team",
      'to': to,
      'message': message,
      'type': '0',
      'routing': '3',
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
