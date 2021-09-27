import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universe/pages/home/domain/entity/user.dart';
import 'package:universe/pages/home/domain/entity/user_prefs.dart';
import 'package:universe/shared/enum.dart';

import '../domain/adapters/repository_adapter.dart';
import '../domain/entity/cases_model.dart';
import 'home_api_provider.dart';

class HomeRepository implements IHomeRepository {
  HomeRepository({required this.provider});
  final IHomeProvider provider;
  Status _status = Status.Uninitialized;
  User _user = User(
      registration: DateTime.now(),
      prefs: UserPrefs(lastLoggedIn: DateTime.now()));
  String _error = '';
  bool _loading = false;

  String get error => _error;
  bool get isLoading => _loading;
  User get user => _user;
  Status get status => _status;

  @override
  Future<CasesModel> getCases() async {
    final cases = await provider.getCases("/summary");
    if (cases.status.hasError) {
      return Future.error(cases.statusText!);
    } else {
      return cases.body!;
    }
  }

  Future signup(
      {String name = 'name',
      String email = 'name@email.com',
      String password = 'password'}) async {
    print("signup Appwrite connection using HomeRepository");
    _status = Status.Authenticating;
    try {
      await provider.apiService
          .signup(name: name, email: email, password: password)
          .then((value) => login(email: email, password: password));
      return true;
    } on AppwriteException catch (e) {
      print('HomeRepository signup error ' + e.message!);
      _error = e.message!;
      _status = Status.Unauthenticated;
      return false;
    }
  }

  @override
  Future login(
      {String email = 'name@email.com', String password = 'password'}) async {
    print("login Appwrite connection using HomeRepository");
    _status = Status.Authenticating;
    try {
      await provider.apiService
          .login(email: email, password: password)
          .then((value) => getUserSession());
      return true;
    } on AppwriteException catch (e) {
      print('HomeRepository login error ' + e.message!);
      _error = e.message!;
      _status = Status.Unauthenticated;
      return false;
    }
  }

  Future logout({String sessionId = 'null'}) async {
    print("logout Appwrite connection using HomeRepository");
    _status = Status.Authenticating;
    try {
      await provider.apiService.logout(sessionId: sessionId);
      _status = Status.Uninitialized;
      return true;
    } on AppwriteException catch (e) {
      print('HomeRepository signup error ' + e.message!);
      _error = e.message!;
      _status = Status.Unauthenticated;
      return false;
    }
  }

  Future getUserSession() async {
    print("getUserSession Appwrite connection using HomeRepository");
    try {
      await provider.apiService.getUserSession().then((res) {
        print('res.data is' + res.data.toString());
        _user = User.fromMap(res.data);
        _saveUserPrefs();
        _status = Status.Authenticated;
      });
    } on AppwriteException catch (e) {
      _status = Status.Unauthenticated;
      _error = e.message!;
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
    await provider.apiService.updatePrefs(prefs.toMap());
    _user = _user.copyWith(prefs: prefs);
  }
}
