import 'package:get/get.dart';
import 'package:universe/pages/home/data/auth_api_provider.dart';
import 'package:universe/pages/home/data/auth_repository.dart';
import 'package:universe/pages/home/domain/adapters/auth_repository_adapter.dart';
import 'package:universe/pages/home/presentation/controllers/auth_controller.dart';
import 'package:universe/pages/home/presentation/controllers/menu_controller.dart';
import 'package:universe/pages/home/presentation/controllers/navigation_controller.dart';
import 'package:universe/pages/home/presentation/controllers/profile_controller.dart';
import 'package:universe/pages/home/data/home_api_provider.dart';

import 'package:universe/pages/home/data/home_repository.dart';
import 'package:universe/pages/home/domain/adapters/repository_adapter.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    print("Running the HomeBinding");
    Get.lazyPut<IHomeProvider>(() => HomeProvider());
    Get.lazyPut<IHomeRepository>(() => HomeRepository(provider: Get.find()));
    Get.lazyPut(() => HomeController(homeRepository: Get.find()));
    Get.lazyPut<IAuthProvider>(() => AuthProvider());
    Get.lazyPut<IAuthRepository>(() => AuthRepository(provider: Get.find()));
    Get.lazyPut(() => AuthController(authRepository: Get.find()));
    Get.lazyPut(() => ProfileController(authRepository: Get.find()));
    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => MenuController());
  }
}
