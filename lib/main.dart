import 'package:flutter/material.dart';
import 'package:time_control/responsive/desktopscreen.dart';
import 'package:time_control/responsive/mobilescreen.dart';
import 'package:time_control/responsive/responsivelayout.dart';

void main() {
  runApp(const MaterialApp(
    home: ResponsiveLayout(
      mobileScreen: MobileScreen(),
      desktopScreen: DesktopScreen(),
    ),
  ));
}
