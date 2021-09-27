import 'dart:async';

import 'package:get/get.dart';
import 'package:universe/pages/home/domain/adapters/auth_repository_adapter.dart';
import 'package:universe/pages/home/domain/entity/user.dart';

//import '../../domain/adapters/repository_adapter.dart';
//import '../../domain/entity/cases_model.dart';

class AuthController extends SuperController<User> {
  AuthController({required this.authRepository});

  /// inject repo abstraction dependency
  final IAuthRepository authRepository;

  RxString sessionId = ''.obs;

  /// When the controller is initialized, make the http request
  @override
  void onInit() {
    super.onInit();
    // show loading on start, data on success
    // and error message on error with 0 boilerplate
    appwriteLogin();
  }

  void appwriteLogin() async {
    bool isLogin;
    isLogin = await authRepository.login(
        email: 'anchkorg@gmail.com', password: 'church2002');
    print("isLogin is " + isLogin.toString());
    if (isLogin) {
      print('homeRepository.user' + authRepository.user.toString());
      sessionId.value = authRepository.user.id!;
      print('sessionId.value is ' + sessionId.value);
      change(authRepository.user, status: RxStatus.success());

//     Future sessionResult = homeRepository.getUserSession();
//     sessionResult.then((value) {
//       print('value on homeRepository.getUserSession');
//       print(value);
//       print('Starting timer counting down at ${DateTime.now()}');
//       new Timer(new Duration(seconds: 35), () {
//         print('Timer at ${DateTime.now()}');
//         Future result = homeRepository.logout(sessionId: sessionId.value);
//         result.then((response) {
//           print(response);
//         }).catchError((error) {
//           print(error.response);
//         });
//       });
//     }).catchError((onError) {
//       print(onError.response);
//     });
//   }
    } else {
      print('Login error');
      print(authRepository.error);
      change(null, status: RxStatus.error(authRepository.error.toString()));
    }
  }

  @override
  void onReady() {
    print('The build method is done. '
        'Your controller is ready to call dialogs and snackbars');
    super.onReady();
  }

  @override
  void onClose() {
    print('onClose called');
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    print('the window size did change');
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    print('platform change ThemeMode');
    super.didChangePlatformBrightness();
  }

  @override
  Future<bool> didPushRoute(String route) {
    print('the route $route will be open');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    print('the current route will be closed');
    return super.didPopRoute();
  }

  @override
  void onDetached() {
    print('onDetached called');
  }

  @override
  void onInactive() {
    print('onInative called');
  }

  @override
  void onPaused() {
    print('onPaused called');
  }

  @override
  void onResumed() {
    print('onResumed called');
  }
}
