//import '../entity/cases_model.dart';

// ignore: one_member_abstracts
import 'package:universe/pages/home/domain/entity/session.dart';
import 'package:universe/pages/home/domain/entity/user.dart';
import 'package:universe/shared/enum.dart';

abstract class IAuthRepository {
  Future signup({String name, String email, String password});
  Future login({String email, String password});
  Future logout({String sessionId});
  Future getUserSession();
  Future updatePrefs(Map<String, dynamic> data);
  Future getInitialsAvatar(String name);
  String get error;
  bool get isLoading;
  User get user;
  Status get status;
  Session get session;
}
