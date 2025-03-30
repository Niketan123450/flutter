import 'package:flutter/material.dart';

abstract class NavbarState {}

class NavbarInitialState extends NavbarState {}

class ChangeNavBarTapState extends NavbarState {
  final int currentIndex;
  final Widget currentScreen;

  ChangeNavBarTapState(this.currentIndex, this.currentScreen);
}
