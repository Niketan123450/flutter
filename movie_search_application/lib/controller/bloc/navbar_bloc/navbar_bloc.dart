import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:movie_search_application/view/bookmarks/bookmarks_screen.dart';
import 'package:movie_search_application/view/home/home.dart';
import 'package:movie_search_application/view/profile/profile_screen.dart';
import 'package:movie_search_application/view/watchList/watchlist_screen.dart';
import 'navbar_event.dart';
import 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarInitialState()) {
    on<OnNavbarTapEvent>(onNavbarTapEvent);
  }

  final List<Widget> _screens = [
    const HomePage(),
    const WatchListScreen(),
    const BookmarksScreen(),
    const ProfileScreen(),
  ];

  FutureOr<void> onNavbarTapEvent(
    OnNavbarTapEvent event,
    Emitter<NavbarState> emit,
  ) {
    emit(
      ChangeNavBarTapState(event.newIndex, _screens.elementAt(event.newIndex)),
    );
  }
}
