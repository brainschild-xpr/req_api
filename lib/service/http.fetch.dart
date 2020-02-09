import 'dart:convert';
import 'dart:async';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:req_api/model.class/user.class.dart';

class FetchUsers {
  static String url = 'http://192.168.43.94:7000/test';

  static Future browse() async {
    http.Response response = await http.get(url);
    String content = response.body;
    List collection = json.decode(content);
    List<User> users = collection.map((json) => User.fromJson(json)).toList();
    return users;
  }
}
//   Future<List<User>> fetchUsers(http.Client client) async {
//   final response = await client.get('http://192.168.43.94:7000/test');
//   return compute(parseUser, response.body);
// }

// // A function that converts a response body into a List<Photo>.
// List<User> parseUser(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<User>((json) => User.fromJson(json)).toList();
// }
// }

// Future<void> main() async {
//   List result = await FetchUsers.browse();
//   print(result);
// }
