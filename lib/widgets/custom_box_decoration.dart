import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration() => const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/blueBubbleBG.JPG"),
          fit: BoxFit.cover),
    );
