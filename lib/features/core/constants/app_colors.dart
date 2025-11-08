
import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF0189C5);     // Main brand color
  static const primaryLight =   Color(0xFF00B4DB);
  static const primaryDark = Color(0xFF0083B0);

  static const secondary = Color(0xFFFFECB3);

  static const background = Color(0xFFF5F5F5);  // Screen background
  static const surface = Color(0xFFFFFFFF);     // Cards, containers

  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0xFF5D4037);
  static const textOnPrimary = Color(0xFFFFFFFF); // Text on primary color

  static const border = Color(0xFFE0E0E0);
  static const divider = Color(0xFFBDBDBD);
  static const fieldColor = Color(0xFFE0E0E0);
  static const error = Colors.red;
  static const warning = Color(0xFFFFAB00);
  static const success = Color(0xFF00C853);
}