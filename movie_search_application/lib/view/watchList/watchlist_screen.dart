import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';

import 'package:movie_search_application/controller/bloc/watchlist_bloc/watchlist_bloc.dart';
import 'package:movie_search_application/controller/bloc/watchlist_bloc/watchlist_event.dart';
import 'package:movie_search_application/controller/bloc/watchlist_bloc/watchlist_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/core/configs/theme/app_text.dart';
import 'package:movie_search_application/view/details/details_screen.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchListBloc()..add(WatchListInitialEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: Text("WatchList", style: AppText.appBarTitle),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.bookmark_border_outlined,
                color: AppColors.primary,
                weight: 23,
                size: 30,
              ),
            ),

            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: AppColors.primary,
                weight: 23,
                size: 30,
              ),
            ),
          ],
          backgroundColor: Colors.black,
        ),

        body: BlocConsumer<WatchListBloc, WatchListState>(
          builder: (BuildContext context, state) {
            if (state is WatchListLoadingState) {
              return CircularProgressIndicator();
            } else if (state is WatchListSuccessState) {
              return (state.watchListList.isEmpty)
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Your Watchlist is Empty!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Add movies to your watchlist to view them here.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    itemCount: state.watchListList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            AppNavigator.push(
                              context,
                              DetailsScreen(
                                movieModel: state.watchListList[index],
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.watchListList[index].posterUrl!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      MediaQuery.of(context).size.width * 0.04,
                                    ),
                                    topRight: Radius.circular(
                                      MediaQuery.of(context).size.width * 0.04,
                                    ),
                                  ),
                                  border: Border(
                                    left: BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                    right: BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                    top: BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 4, // Height of the bottom border
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.secondary,
                                        AppColors.secondary,
                                        AppColors.secondary,
                                        AppColors.secondary,
                                        AppColors.secondary,
                                        AppColors.secondary,
                                        AppColors.primary,
                                        AppColors.primary,
                                        AppColors.primary,
                                        AppColors.primary,
                                        AppColors.primary,
                                        AppColors.primary,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),

                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Stack(
                                      children: [
                                        Icon(
                                          Icons.play_arrow_rounded,
                                          color: AppColors.primary,
                                          size:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.08,
                                        ),
                                        Positioned(
                                          top: 4,
                                          left: 4,
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.black,
                                            size:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.07,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.54,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.033,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                        ),
                                      ),
                                      child: Text(
                                        "Continue watching",
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Container(
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       image: NetworkImage(
                          //         state.watchListList[index].posterUrl!,
                          //       ),
                          //       fit: BoxFit.cover,
                          //     ),
                          //     borderRadius: BorderRadius.circular(
                          //       MediaQuery.of(context).size.width * 0.04,
                          //     ),
                          //     border: Border.all(
                          //       color: AppColors.primary,
                          //       width: 2,
                          //     ),
                          //   ),
                          //   width: MediaQuery.of(context).size.width,
                          //   height: MediaQuery.of(context).size.height * 0.25,
                          // ),
                        ),
                      );
                    },
                  );
            } else if (state is WatchListFailureState) {
              return Center(child: Container());
            } else {
              return SizedBox.shrink();
            }
          },
          listener: (BuildContext context, WatchListState state) {
            if (state is WatchListSuccessState) {
              return log("Event is Trigger::::${state.watchListList}");
            }
          },
        ),
      ),
    );
  }
}
