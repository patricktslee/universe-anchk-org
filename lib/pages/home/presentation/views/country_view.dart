import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class CountryView extends GetResponsiveView<HomeController> {
  @override
  Widget builder() {
    return screen.isPhone ? iPhoneScreen() : desktopScreen();
  }

  Container iPhoneScreen() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.linearToSrgbGamma(),
              image: NetworkImage(
                  "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('corona_by_country'.tr),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: Center(
              child: ListView.builder(
                  itemCount: controller.state!.countries.length,
                  itemBuilder: (context, index) {
                    final country = controller.state!.countries[index];

                    return ListTile(
                      onTap: () {
                        Get.toNamed('/home/country/details',
                            arguments: country);
                      },
                      trailing: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://flagcdn.com/48x36/${country.countryCode.toLowerCase()}.png"),
                      ),
                      title: Text(country.country),
                      subtitle: Text(
                          // ignore: lines_longer_than_80_chars
                          '${'total_infecteds'.tr}${' ${country.totalConfirmed}'}'),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Container desktopScreen() {
    double screenWidth = screen.width.toDouble();
    double screenHeight = screen.height.toDouble();
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.linearToSrgbGamma(),
              image: NetworkImage(
                  "https://images.pexels.com/photos/3902882/pexels-photo-3902882.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('corona_by_country'.tr),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            body: Center(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: screenWidth / (screenHeight / 10),
                  ),
                  itemCount: controller.state!.countries.length,
                  itemBuilder: (context, index) {
                    final country = controller.state!.countries[index];

                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.toNamed('/home/country/details',
                              arguments: country);
                        },
                        trailing: CircleAvatar(
                          radius: 32.0,
                          child: ClipRRect(
                            child: Image.network(
                                "https://flagcdn.com/48x36/${country.countryCode.toLowerCase()}.png"),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        title: Text(country.country),
                        subtitle: Text(
                            // ignore: lines_longer_than_80_chars
                            '${'total_infecteds'.tr}${' ${country.totalConfirmed}'}'),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
