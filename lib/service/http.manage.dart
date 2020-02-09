import 'dart:async';
import 'package:req_api/model.class/user.class.dart';
import 'package:req_api/service/http.fetch.dart';

class UserManager {
  final StreamController<int> _userManage = StreamController<int>();
  Stream<int> get userManage => _userManage.stream;

  Stream<List<User>> get userManageListView async* {
    yield await FetchUsers.browse();
  }

  UserManager() {
    userManageListView.listen((list) => _userManage.add(list.length));
  }
}
