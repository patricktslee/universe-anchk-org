import 'package:get/get.dart';
import 'package:universe/pages/home/data/api_service.dart';
import '../domain/entity/cases_model.dart';

// ignore: one_member_abstracts
abstract class IHomeProvider {
  late ApiService apiService;
  Future<Response<CasesModel>> getCases(String path);
}

class HomeProvider extends GetConnect implements IHomeProvider {
  ApiService apiService = ApiService.instance;
  @override
  void onInit() {
    print("HomeProvider Oninit");
    httpClient.defaultDecoder =
        (val) => CasesModel.fromJson(val as Map<String, dynamic>);
    httpClient.baseUrl = 'https://api.covid19api.com';
  }

  @override
  Future<Response<CasesModel>> getCases(String path) => get(path);
}
