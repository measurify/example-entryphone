import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  static String authToken;

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print('response code: ' + response.statusCode.toString());
      var data = jsonDecode(response.body);
      return data;
    } else {
      print(response.statusCode);
    }
  }

  static Future<String> getToken(
      String url, String username, String password) async {
    print('--- Getting Token ---');
    String body = jsonEncode({"username": username, "password": password});
    Map<String, String> headers = {"Content-Type": "application/json"};
    http.Response response = await http.post(url, headers: headers, body: body);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    Map<String, dynamic> resBody = jsonDecode(response.body);
    if (response.statusCode == 401)
      return 0.toString();
    else {
      // print('Response body: ' + resBody.toString());
      // print('Token: ' + resBody['token'].toString());
      authToken = resBody['token'];
      return resBody['token'];
    }
  }

  static Future<String> makeSubscription(
      String url, String token, String device) async {
    String body = jsonEncode({"token": token, "device": device});
    print(body);

    Map<String, String> headers = {
      "Authorization": authToken,
      "Content-Type": "application/json"
    };

    http.Response response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) return 1.toString();
    if (response.statusCode == 400)
      return 0.toString();
    else
      return 2.toString();
  }

  // static Future<String> getVideo(
  //     String url, String device, String measurement) async {
  //   Map<String, String> headers = {
  //     "Authorization": authToken,
  //     "Content-Type": "application/json"
  //   };

  //   String response =
  //       //await http.get(url + measurement + "/file?Authorization=" + authToken);
  //   return response;
  // }

  static Future<String> postALockMeasurement() async {
    String body = jsonEncode({
      "thing": "lock",
      "feature": "entry",
      "device": "door-opener",
      "samples": [
        {
          "values": [1, 1]
        }
      ]
    });
    Map<String, String> headers = {
      "Authorization": authToken,
      "Content-Type": "application/json"
    };
    String url = "http://students.atmosphere.tools/v1/measurements";
    http.Response response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 401)
      return 0.toString();
    else {
      return 1.toString();
    }
  }

  static Future<String> getMeasurementID(
      String url, String token, String device) async {
    Map<String, String> headers = {
      "Authorization": authToken,
      "limit": "1",
      "Content-Type": "application/json"
    };

    http.Response response = await http.get(url, headers: headers);
    return response.body;
  }
}
