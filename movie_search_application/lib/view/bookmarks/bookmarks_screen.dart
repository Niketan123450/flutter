import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/controller/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:movie_search_application/controller/bloc/bookmark_bloc/bookmark_event.dart';
import 'package:movie_search_application/controller/bloc/bookmark_bloc/bookmark_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/core/configs/theme/app_text.dart';
import 'package:movie_search_application/view/details/details_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkBloc()..add(BookmarkInitialEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: Text("Bookmark", style: AppText.appBarTitle),

          backgroundColor: Colors.black,
        ),
        body: BlocConsumer<BookmarkBloc, BookmarkState>(
          builder: (BuildContext context, state) {
            if (state is BookmarkLoadingState) {
              return CircularProgressIndicator();
            } else if (state is BookmarkSuccessState) {
              return (state.bookmarkList.isEmpty)
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_outline,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No bookmarks yet!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Add movies to your bookmark list to see them here.",
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
                    itemCount: state.bookmarkList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            AppNavigator.push(
                              context,
                              DetailsScreen(
                                movieModel: state.bookmarkList[index],
                              ),
                            );
                          },
                          child: Container(
                            // color: Colors.amber,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.27,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.25,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state
                                                .bookmarkList[index]
                                                .posterUrl!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 2,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.bookmark_sharp,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.6,
                                        child: Text(
                                          state.bookmarkList[index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppText.secondaryTitle,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            state.bookmarkList[index].duration!,
                                            style: AppText.smallText,
                                          ),
                                          Text(
                                            state.bookmarkList[index].genre!,
                                            style: AppText.smallText,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.6,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          state
                                              .bookmarkList[index]
                                              .description!,
                                          style: AppText.description,
                                        ),
                                      ),
                                      Text(
                                        "Review",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        style: GoogleFonts.montserrat(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            initialRating:
                                                state
                                                    .bookmarkList[index]
                                                    .rating!, // Set initial rating
                                            // glowColor: ,
                                            itemSize: 25,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Icon(
                                                Icons.star,
                                                color: AppColors.primary,
                                              );
                                            },
                                            onRatingUpdate: (rating) {},
                                          ),
                                          Text(
                                            "(${state.bookmarkList[index].rating!})",
                                            style: AppText.secondaryDescription,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
            } else if (state is BookmarkFailureState) {
              return Center(child: Container());
            } else {
              return SizedBox.shrink();
            }
          },
          listener: (BuildContext context, BookmarkState state) {
            if (state is BookmarkSuccessState) {
              return log("Event is Trigger::::${state.bookmarkList}");
            }
          },
        ),
      ),
    );
  }
}
