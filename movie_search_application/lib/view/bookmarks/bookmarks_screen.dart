import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/controller/bookmark_bloc/bookmark_bloc.dart';
import 'package:movie_search_application/controller/bookmark_bloc/bookmark_event.dart';
import 'package:movie_search_application/controller/bookmark_bloc/bookmark_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/core/configs/theme/app_text.dart';

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
          leading: IconButton(
            onPressed: () {
              AppNavigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.primary),
          ),
          title: Text(
            "Bookmarks",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: BlocConsumer<BookmarkBloc, BookmarkState>(
          builder: (BuildContext context, state) {
            if (state is BookmarkLoadingState) {
              return CircularProgressIndicator();
            } else if (state is BookmarkSuccessState) {
              return ListView.builder(
                itemCount: state.bookmarkList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        context.read<BookmarkBloc>().add(
                          AddBookmarkEvent(movie: state.bookmarkList[index]),
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    state.bookmarkList[index].posterUrl!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    // width: MediaQuery.of(context).size.width,
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
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      state.bookmarkList[index].description!,
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
