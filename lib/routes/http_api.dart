import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:req_api/model.class/photo.class.dart';

class HttpApi extends StatelessWidget {
  const HttpApi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
      future: fetchUsers(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? PhotosList(photos: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      // ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.amber,
            child: Column(
              children: <Widget>[
                // Image.network(photos[index].thumbnailUrl),
                Text(photos[index].firstName),
                Text(photos[index].lastname),
                Text(photos[index].email),
                Text(photos[index].userId),
                Text(photos[index].phone.toString())
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<List<Photo>> fetchUsers(http.Client client) async {
  final response = await client.get('http://192.168.43.94:7000/test');
  print(response.body);

  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  print(parsed);

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

// Future<http.Response> fetchPhotos(http.Client client) async {
//   return client.get('https://jsonplaceholder.typicode.com/photos');
// }
