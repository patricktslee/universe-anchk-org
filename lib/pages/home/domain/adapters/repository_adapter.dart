import 'package:universe/pages/home/domain/entity/user.dart';
import 'package:universe/shared/enum.dart';

import '../entity/cases_model.dart';

// ignore: one_member_abstracts
abstract class IHomeRepository {
  Future<CasesModel> getCases();
  Future signup({String name, String email, String password});
  Future login({String email, String password});
  Future logout({String sessionId});
  Future getUserSession();
  String get error;
  bool get isLoading;
  User get user;
  Status get status;
}
