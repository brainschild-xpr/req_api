import 'package:flutter/material.dart';
import 'package:req_api/routes/http_api.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return HttpApi();
  }
}
