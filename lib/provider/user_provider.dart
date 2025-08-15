import 'package:flutter/material.dart';
import 'package:instagram_clone1/model/user.dart';
import 'package:instagram_clone1/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  late User _user;
  final AuthMedthod _authMedthod = AuthMedthod();

  bool _isUserInitialized = false;

  User get getUser => _user;
  // 플래그에 대한 getter를 제공합니다.
  bool get isUserInitialized => _isUserInitialized;

  Future<void> refreshUser() async {
    User user = await _authMedthod.getUserDetails();
    _user = user;
    // 사용자 초기화가 완료되었음을 표시합니다.
    _isUserInitialized = true;
    notifyListeners();
  }
}
