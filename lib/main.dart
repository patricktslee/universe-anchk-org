import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/layout.dart';
import 'package:universe/pages/404/error.dart';
import 'package:universe/pages/authentication/authentication.dart';
import 'package:universe/pages/home/bindings/home_binding.dart';
import 'package:universe/pages/home/presentation/views/home_layout.dart';
//import 'package:universe/pages/home/presentation/views/home_view.dart';
import 'package:universe/routing/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    final platform = Theme.of(context).platform;
//    print("In main.dart The Platform is ${platform.toString()}");

    return GetMaterialApp(
      initialRoute: rootRoute,
      unknownRoute: GetPage(
          name: '/not-found',
          page: () => PageNotFound(),
          transition: Transition.fadeIn),
      getPages: [
        GetPage(
            name: rootRoute,
            binding: HomeBinding(),
            page: () {
              return HomeLayout();
              // SiteLayout();
            }),
        GetPage(
            name: authenticationPageRoute,
            page: () => const AuthenticationPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: '萬國宣道詠團',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
      ),
      // home: AuthenticationPage(),
    );
  }
}
