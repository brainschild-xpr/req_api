import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:req_api/model.class/user.class.dart';

class HttpApi extends StatelessWidget {
  const HttpApi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: fetchUsers(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? UserList(user: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class UserList extends StatelessWidget {
  final List<User> user;

  UserList({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: user.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(top: 10, left: 10,right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.teal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user[index].firstName,
                        style: buildTextStyle(),
                      ),
                      Text(
                        user[index].lastname,
                        style: buildTextStyle(),
                      ),
                      Text(
                        user[index].username,
                        style: buildTextStyle(),
                      ),
                      Text(
                        user[index].email,
                        style: buildTextStyle(),
                      ),
                      Text(
                        user[index].userId,
                        style: buildTextStyle(),
                      ),
                      Text(
                        '+254' + user[index].phone.toString(),
                        style: buildTextStyle(),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          MaterialButton(
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.green,
                            onPressed: () {},
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          MaterialButton(
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
  }
}

Future<List<User>> fetchUsers(http.Client client) async {
  final response = await client.get('http://192.168.43.94:7000/test');
  return compute(parseUser, response.body);
}

// A function that converts a response body into a List<Photo>.
List<User> parseUser(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
