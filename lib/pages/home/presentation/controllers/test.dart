import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:universe/pages/home/data/api_service.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.sphlash,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    initialBinding: MyPageBinding(),
    getPages: AppPages.pages,
    home: const SplashPage(),
  ));
}

class MyController extends GetxController {
  final MyRepository repository;
  MyController({required this.repository});

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}

abstract class IMyRepository {}

class MyRepository implements IMyRepository {
  MyRepository({required this.provider});
  final IProvider provider;
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const MyHomePage(),
    )
  ];
}

abstract class IProvider {
  late ApiService apiService;
}

class Provider extends GetConnect implements IProvider {
  @override
  ApiService apiService = ApiService.instance;
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  @override
  void onInit() {}
}

class MyPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IProvider>(() => Provider());
    Get.lazyPut<IMyRepository>(() => MyRepository(provider: Get.find()));
    Get.lazyPut<MyController>(() => MyController(repository: Get.find()));
  }
}

class Routes {
  static const sphlash = '/splash';
  static const home = '/';
}

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  fontFamily: 'Georgia',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
);

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
