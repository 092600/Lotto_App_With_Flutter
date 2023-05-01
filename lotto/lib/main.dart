import 'package:flutter/material.dart';
import 'package:lotto/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'NanumGothic',
    ),
    home: const HomeScreen(),
  ));
}
