import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:universe/pages/home/data/api_service.dart';
//import '../domain/entity/cases_model.dart';

// ignore: one_member_abstracts
abstract class IAuthProvider {
  ApiService? apiService;
//  Future<Response<CasesModel>> getCases(String path);
}

class AuthProvider extends GetConnect implements IAuthProvider {
  @override
  ApiService? apiService = ApiService.instance;
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  @override
  void onInit() {
    logger.i("AuthProvider OnInit");
//   httpClient.defaultDecoder = CasesModel.fromJson;
//   httpClient.baseUrl = 'https://api.covid19api.com';
  }

// @override
// Future<Response<CasesModel>> getCases(String path) => get(path);
}
