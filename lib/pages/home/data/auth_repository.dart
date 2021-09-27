import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universe/pages/home/data/auth_api_provider.dart';
import 'package:universe/pages/home/domain/adapters/auth_repository_adapter.dart';
import 'package:universe/pages/home/domain/entity/session.dart';
import 'package:universe/pages/home/domain/entity/user.dart';
import 'package:universe/pages/home/domain/entity/user_prefs.dart';
import 'package:universe/shared/enum.dart';

//import '../domain/entity/cases_model.dart';
//import 'home_api_provider.dart';

class AuthRepository implements IAuthRepository {
  Status _status = Status.Uninitialized;
  User _user = User(
      registration: DateTime.now(),
      prefs: UserPrefs(lastLoggedIn: DateTime.now()));
  String _error = '';
  bool _loading = false;
  Session _session = Session();

  String get error => _error;
  bool get isLoading => _loading;
  User get user => _user;
  Status get status => _status;
  Session get session => _session;

  IAuthProvider? _provider;
  static bool _isInstanceCreated = false;

  factory AuthRepository({required IAuthProvider provider}) {
    if (_isInstanceCreated == false) {
      _isInstanceCreated = true;
      _instance = AuthRepository._internal(provider);
    }
    return _instance;
  }

  static late final AuthRepository _instance;

  AuthRepository._internal(IAuthProvider provider) {
    print('Starting AuthRepository._internal(this.provider)');
    _provider = provider;
  }

  //static AuthRepository get instance {
  //  if (_instance == null) {
  //    _instance = AuthRepository._internal();
  //  }
  //  return _instance;
  //}

  Future signup(
      {String name = 'name',
      String email = 'name@email.com',
      String password = 'password'}) async {
    print("signup Appwrite connection using AuthRepository");
    _status = Status.Authenticating;
    try {
      await _provider!.apiService!
          .signup(name: name, email: email, password: password)
          .then((value) => login(email: email, password: password));
      return true;
    } on AppwriteException catch (e) {
      print('AuthRepository signup error ' + e.message!);
      _error = e.message!;
      _status = Status.Unauthenticated;
      return false;
    }
  }

  @override
  Future login(
      {String email = 'name@email.com', String password = 'password'}) async {
    bool userExisted = true;
    print("login Appwrite connection using AuthRepository");
    _status = Status.Authenticating;
    userExisted = _user.name == "Null name" ? false : true;
    print('AuthRepository login userExisted is ' + userExisted.toString());
    try {
      await _provider!.apiService!
          .login(email: email, password: password)
          .then((res) {
        print('res.data for Session is' + res.data.toString());
        _session = Session.fromMap(res.data);
        print('_session is' + _session.toString());
        _status = Status.Authenticated;
      });
//      getUserSession();

      return true;
    } on AppwriteException catch (e) {
      print('AuthRepository login error ' + e.message!);
      _error = e.message!;
      _status = Status.Unauthenticated;
      return false;
    }
  }

  Future logout({String sessionId = 'null'}) async {
    print("logout Appwrite connection using AuthRepository");
    _status = Status.Authenticating;
    try {
      await _provider!.apiService!.logout(sessionId: sessionId);
      _status = Status.Uninitialized;
      _user = User(
          registration: DateTime.now(),
          prefs: UserPrefs(lastLoggedIn: DateTime.now()));
      return true;
    } on AppwriteException catch (e) {
      print('AuthRepository signup error ' + e.message!);
      _error = e.message!;
      _status = Status.Unauthenticated;
      return false;
    }
  }

  Future getUserSession() async {
    print("getUserSession Appwrite connection using AuthRepository");
    try {
      await _provider!.apiService!.getUserSession().then((res) {
        print('res.data is' + res.data.toString());
        _user = User.fromMap(res.data);
        print('_user is' + _user.toString());
        _saveUserPrefs();
        _status = Status.Authenticated;
      });
      return true;
    } on AppwriteException catch (e) {
      _status = Status.Unauthenticated;
      _error = e.message!;
      return false;
    } finally {
      _loading = false;
    }
  }

  _saveUserPrefs() async {
//    if (_user == null) return;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var deviceId = '';
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceId = webBrowserInfo.userAgent;
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId!;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor!;
      }
    }

    var prefs = UserPrefs(lastLoggedIn: DateTime.now());
    prefs = prefs.copyWith(
      buildNumber: buildNumber,
      lastLoggedIn: DateTime.now(),
      introSeen: false,
      deviceId: deviceId,
    );
    await _provider!.apiService!.updatePrefs(prefs.toMap());
    _user = _user.copyWith(prefs: prefs);
  }

  Future getInitialsAvatar(String name) async {
    return true;
  }

  Future updatePrefs(Map<String, dynamic> data) async {
    return true;
  }
}
