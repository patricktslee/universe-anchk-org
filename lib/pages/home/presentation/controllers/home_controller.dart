import 'dart:async';

//import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

import 'package:universe/pages/home/domain/adapters/repository_adapter.dart';
import 'package:universe/pages/home/domain/entity/cases_model.dart';

class HomeController extends SuperController<CasesModel> {
  HomeController({required this.homeRepository});

  /// inject repo abstraction dependency
  final IHomeRepository homeRepository;

  RxString sessionId = ''.obs;

  /// When the controller is initialized, make the http request
  @override
  void onInit() {
    super.onInit();
    // show loading on start, data on success
    // and error message on error with 0 boilerplate
    homeRepository.getCases().then((data) {
      print(data.toJson().toString());
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
//    appwriteLogin();
  }

  Future<void> appwriteLogin() async {
    bool isLogin;
    isLogin = await homeRepository.login(
        email: 'anchkorg@gmail.com', password: 'church2002');
    print("isLogin is " + isLogin.toString());
    if (isLogin) {
      print('homeRepository.user' + homeRepository.user.toString());
      sessionId.value = homeRepository.user.id!;
      print('sessionId.value is ' + sessionId.value);
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
      print(homeRepository.error);
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
