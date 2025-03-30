import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search_application/controller/bloc/navbar_bloc/navbar_bloc.dart';
import 'package:movie_search_application/controller/bloc/navbar_bloc/navbar_event.dart';
import 'package:movie_search_application/controller/bloc/navbar_bloc/navbar_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';

class NavbarScreen extends StatelessWidget {
  final int selectedIndex;

  const NavbarScreen({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              NavbarBloc()..add(
                OnNavbarTapEvent(newIndex: selectedIndex),
              ), // Set initial index
      child: const NavbarView(),
    );
  }
}

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        if (state is ChangeNavBarTapState) {
          return Scaffold(
            body: state.currentScreen,
            backgroundColor: Colors.white,
            bottomNavigationBar: SizedBox(
              height: 80,
              child: BottomNavigationBar(
                currentIndex: state.currentIndex,
                onTap: (index) {
                  context.read<NavbarBloc>().add(
                    OnNavbarTapEvent(newIndex: index),
                  );
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.primary,
                selectedLabelStyle: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                selectedItemColor: Colors.black,
                unselectedItemColor: AppColors.secondBackground,
                unselectedLabelStyle: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.watch_later),
                    label: "WatchList",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark),
                    label: "BookMark",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
