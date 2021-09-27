import 'package:get/get.dart';
import 'package:universe/pages/home/data/ApiService.dart';
//import '../domain/entity/cases_model.dart';

// ignore: one_member_abstracts
abstract class IAuthProvider {
  ApiService? apiService;
//  Future<Response<CasesModel>> getCases(String path);
}

class AuthProvider extends GetConnect implements IAuthProvider {
  ApiService? apiService = ApiService.instance;
  @override
  void onInit() {
    print("AuthProvider Oninit");
//   httpClient.defaultDecoder = CasesModel.fromJson;
//   httpClient.baseUrl = 'https://api.covid19api.com';
  }

// @override
// Future<Response<CasesModel>> getCases(String path) => get(path);
}