import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:movie_search_application/common/helper/navigation/app_navigation.dart';
import 'package:movie_search_application/controller/bloc/details_bloc/details_bloc.dart';
import 'package:movie_search_application/controller/bloc/details_bloc/details_event.dart';
import 'package:movie_search_application/controller/bloc/details_bloc/details_state.dart';
import 'package:movie_search_application/core/configs/theme/app_colors.dart';
import 'package:movie_search_application/core/configs/theme/app_text.dart';
import 'package:movie_search_application/model/movie_model.dart';
import 'package:movie_search_application/view/search/search_screen.dart';

class DetailsScreen extends StatefulWidget {
  final MovieModel movieModel;
  const DetailsScreen({super.key, required this.movieModel});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsBloc()..add(DetailsInitialEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,

        body: BlocConsumer<DetailsBloc, DetailsState>(
          builder: (BuildContext context, state) {
            if (state is DetailsLoadingState) {
              return CircularProgressIndicator();
            } else if (state is DetailsSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              AppNavigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text("Details", style: AppText.appBarTitle),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              if ((state.bookmarkList.any(
                                (movie) =>
                                    movie.title!.toLowerCase() ==
                                    widget.movieModel.title!.toLowerCase(),
                              ))) {
                                context.read<DetailsBloc>().add(
                                  RemoveBookmarkEvent(movie: widget.movieModel),
                                );
                              } else {
                                context.read<DetailsBloc>().add(
                                  AddBookmarkEvent(movie: widget.movieModel),
                                );
                              }
                            },
                            icon: Icon(
                              (state.bookmarkList.any(
                                    (movie) =>
                                        movie.title!.toLowerCase() ==
                                        widget.movieModel.title!.toLowerCase(),
                                  ))
                                  ? Icons.bookmark_sharp
                                  : Icons.bookmark_border_outlined,
                              color: AppColors.primary,
                              weight: 23,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if ((state.watchListList.any(
                                (movie) =>
                                    movie.title!.toLowerCase() ==
                                    widget.movieModel.title!.toLowerCase(),
                              ))) {
                                context.read<DetailsBloc>().add(
                                  RemoveWatchListEvent(
                                    movie: widget.movieModel,
                                  ),
                                );
                              } else {
                                context.read<DetailsBloc>().add(
                                  AddWatchListEvent(movie: widget.movieModel),
                                );
                              }
                            },
                            icon: Icon(
                              (state.watchListList.any(
                                    (movie) =>
                                        movie.title!.toLowerCase() ==
                                        widget.movieModel.title!.toLowerCase(),
                                  ))
                                  ? Icons.watch_later
                                  : Icons.watch_later_outlined,
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
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: MediaQuery.of(context).size.height * 0.27,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(widget.movieModel.posterUrl!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                // clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 71, 71, 71),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  border: Border.symmetric(
                                    vertical: BorderSide(
                                      color: const Color.fromARGB(
                                        255,
                                        71,
                                        71,
                                        71,
                                      ),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Releasing on 16 july 2010",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(widget.movieModel.title!, style: AppText.primaryTitle),
                  Text(
                    widget.movieModel.duration!,
                    style: AppText.secondaryDescription,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.movieModel.description!,
                      style: AppText.primaryDescription,
                    ),
                  ),
                  Text("Review", style: AppText.secondaryTitle),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating:
                            widget.movieModel.rating!, // Set initial rating
                        // glowColor: ,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, index) {
                          return Icon(Icons.star, color: AppColors.primary);
                        },
                        onRatingUpdate: (rating) {},
                      ),
                      Text(
                        "(${widget.movieModel.rating!})",
                        style: AppText.secondaryDescription,
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is DetailsFailureState) {
              return Center(child: Container());
            } else {
              return SizedBox.shrink();
            }
          },
          listener: (BuildContext context, DetailsState state) {
            if (state is DetailsSuccessState) {
              return log("Event is Trigger::::${state.bookmarkList}");
            }
          },
        ),
      ),
    );
  }
}
